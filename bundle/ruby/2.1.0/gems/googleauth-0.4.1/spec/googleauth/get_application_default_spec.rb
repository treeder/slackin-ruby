# Copyright 2015, Google Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following disclaimer
# in the documentation and/or other materials provided with the
# distribution.
#     * Neither the name of Google Inc. nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

spec_dir = File.expand_path(File.join(File.dirname(__FILE__)))
$LOAD_PATH.unshift(spec_dir)
$LOAD_PATH.uniq!

require 'faraday'
require 'googleauth'
require 'spec_helper'

describe '#get_application_default' do
  before(:example) do
    @key = OpenSSL::PKey::RSA.new(2048)
    @var_name = CredentialsLoader::ENV_VAR
    @orig = ENV[@var_name]
    @home = ENV['HOME']
    @scope = 'https://www.googleapis.com/auth/userinfo.profile'
  end

  after(:example) do
    ENV[@var_name] = @orig unless @orig.nil?
    ENV['HOME'] = @home unless @home == ENV['HOME']
  end

  shared_examples 'it cannot load misconfigured credentials' do
    it 'fails if the GOOGLE_APPLICATION_CREDENTIALS path does not exist' do
      Dir.mktmpdir do |dir|
        key_path = File.join(dir, 'does-not-exist')
        ENV[@var_name] = key_path
        expect { Google::Auth.get_application_default(@scope) }.to raise_error
      end
    end

    it 'fails without default file or env if not on compute engine' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/') do |_env|
          [404,
           { 'Metadata-Flavor' => 'Google' },
           '']
        end
      end  # GCE not detected
      Dir.mktmpdir do |dir|
        ENV.delete(@var_name) unless ENV[@var_name].nil? # no env var
        ENV['HOME'] = dir  # no config present in this tmp dir
        c = Faraday.new do |b|
          b.adapter(:test, stubs)
        end
        blk = proc do
          Google::Auth.get_application_default(@scope, connection: c)
        end
        expect(&blk).to raise_error
      end
      stubs.verify_stubbed_calls
    end
  end

  shared_examples 'it can successfully load credentials' do
    it 'succeeds if the GOOGLE_APPLICATION_CREDENTIALS file is valid' do
      Dir.mktmpdir do |dir|
        key_path = File.join(dir, 'my_cert_file')
        FileUtils.mkdir_p(File.dirname(key_path))
        File.write(key_path, cred_json_text)
        ENV[@var_name] = key_path
        expect(Google::Auth.get_application_default(@scope)).to_not be_nil
      end
    end

    it 'succeeds with default file without GOOGLE_APPLICATION_CREDENTIALS' do
      ENV.delete(@var_name) unless ENV[@var_name].nil?
      Dir.mktmpdir do |dir|
        key_path = File.join(dir, '.config',
                             CredentialsLoader::WELL_KNOWN_PATH)
        FileUtils.mkdir_p(File.dirname(key_path))
        File.write(key_path, cred_json_text)
        ENV['HOME'] = dir
        expect(Google::Auth.get_application_default(@scope)).to_not be_nil
      end
    end

    it 'succeeds with default file without a scope' do
      ENV.delete(@var_name) unless ENV[@var_name].nil?
      Dir.mktmpdir do |dir|
        key_path = File.join(dir, '.config',
                             CredentialsLoader::WELL_KNOWN_PATH)
        FileUtils.mkdir_p(File.dirname(key_path))
        File.write(key_path, cred_json_text)
        ENV['HOME'] = dir
        expect(Google::Auth.get_application_default).to_not be_nil
      end
    end

    it 'succeeds without default file or env if on compute engine' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/') do |_env|
          [200,
           { 'Metadata-Flavor' => 'Google' },
           '']
        end
      end  # GCE detected
      Dir.mktmpdir do |dir|
        ENV.delete(@var_name) unless ENV[@var_name].nil? # no env var
        ENV['HOME'] = dir  # no config present in this tmp dir
        c = Faraday.new do |b|
          b.adapter(:test, stubs)
        end
        creds = Google::Auth.get_application_default(
          @scope,
          connection: c)
        expect(creds).to_not be_nil
      end
      stubs.verify_stubbed_calls
    end
  end

  describe 'when credential type is service account' do
    def cred_json_text
      cred_json = {
        private_key_id: 'a_private_key_id',
        private_key: @key.to_pem,
        client_email: 'app@developer.gserviceaccount.com',
        client_id: 'app.apps.googleusercontent.com',
        type: 'service_account'
      }
      MultiJson.dump(cred_json)
    end

    it_behaves_like 'it can successfully load credentials'
    it_behaves_like 'it cannot load misconfigured credentials'
  end

  describe 'when credential type is authorized_user' do
    def cred_json_text
      cred_json = {
        client_secret: 'privatekey',
        refresh_token: 'refreshtoken',
        client_id: 'app.apps.googleusercontent.com',
        type: 'authorized_user'
      }
      MultiJson.dump(cred_json)
    end

    it_behaves_like 'it can successfully load credentials'
    it_behaves_like 'it cannot load misconfigured credentials'
  end

  describe 'when credential type is unknown' do
    def cred_json_text
      cred_json = {
        client_secret: 'privatekey',
        refresh_token: 'refreshtoken',
        client_id: 'app.apps.googleusercontent.com',
        type: 'not_known_type'
      }
      MultiJson.dump(cred_json)
    end

    it 'fails if the GOOGLE_APPLICATION_CREDENTIALS file contains the creds' do
      Dir.mktmpdir do |dir|
        key_path = File.join(dir, 'my_cert_file')
        FileUtils.mkdir_p(File.dirname(key_path))
        File.write(key_path, cred_json_text)
        ENV[@var_name] = key_path
        blk = proc do
          Google::Auth.get_application_default(@scope)
        end
        expect(&blk).to raise_error RuntimeError
      end
    end

    it 'fails if the well known file contains the creds' do
      ENV.delete(@var_name) unless ENV[@var_name].nil?
      Dir.mktmpdir do |dir|
        key_path = File.join(dir, '.config',
                             CredentialsLoader::WELL_KNOWN_PATH)
        FileUtils.mkdir_p(File.dirname(key_path))
        File.write(key_path, cred_json_text)
        ENV['HOME'] = dir
        blk = proc do
          Google::Auth.get_application_default(@scope)
        end
        expect(&blk).to raise_error RuntimeError
      end
    end
  end
end
