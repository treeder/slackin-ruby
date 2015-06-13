# This file was auto-generated by lib/generators/tasks/generate.rb

module Slack
  module Endpoint
    module Stars
      #
      # This method lists the items starred by a user.
      #
      # @option options [Object] :user
      #   Show stars by this user. Defaults to the authed user.
      # @option options [Object] :count
      #   Number of items to return per page.
      # @option options [Object] :page
      #   Page number of results to return.
      # @see https://api.slack.com/methods/stars.list
      # @see https://github.com/slackhq/slack-api-docs/blob/master/methods/stars.list.md
      # @see https://github.com/slackhq/slack-api-docs/blob/master/methods/stars.list.json
      def stars_list(options={})
        post("stars.list", options)
      end

    end
  end
end
