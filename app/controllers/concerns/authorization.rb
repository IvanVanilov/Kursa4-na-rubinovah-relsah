module Authentication
    extend ActiveSupport::Concern

    included do
        include Pundit
    end
end