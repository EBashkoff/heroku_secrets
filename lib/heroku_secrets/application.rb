module HerokuSecrets
  module Application
    def self.included(base)

      base.class_eval do
        alias_method(:secrets_from_yaml, :secrets)

        def secrets
          @secrets ||= begin
            secrets = secrets_from_yaml

            ::ENV.each { |var, val|
              secrets[var.downcase] = val
            }

            secrets
          end
        end

        def reload_secrets!
          @secrets = nil
          secrets
        end
      end

    end
  end
end
