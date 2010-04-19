module Garb
  class Session
    module Methods
      attr_accessor :auth_token, :access_token, :email

      # use only for single user authentication
      def login(email, password, opts={})
        self.email = email
        auth_request = AuthenticationRequest.new(email, password, opts)
        self.auth_token = auth_request.auth_token(opts)
      end

      def single_user?
        auth_token && auth_token.is_a?(String)
      end

      def oauth_user?
        !access_token.nil?
      end

      def auth_sub(token)
        self.auth_token = token
        @auth_sub = true
      end

      def auth_sub?
        @auth_sub
      end

    end

    include Methods
    extend Methods
  end
end
