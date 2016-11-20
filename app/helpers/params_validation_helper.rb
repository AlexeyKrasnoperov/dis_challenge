module ParamsValidationHelper
  extend ActiveSupport::Concern

  module ClassMethods
    def params(method = nil, &block)
      builder = ValidationBuilder.new(self)
      builder.instance_eval(&block) if block_given?

      if method
        validate_params(builder.validator, method)
      else
        @request_params_validator = builder.validator
      end
    end

    def method_added(method)
      if @request_params_validator.present?
        request_params_validator = @request_params_validator
        @request_params_validator = nil

        validate_params(request_params_validator, method)
      end
      super
    end

    private

    def validate_params(validator, method)
      before_action only: [method] do
        request_params = validator.new(params)
        if request_params.invalid?
          fail BadRequestError.new('invalid_param', request_params.errors.full_messages.first)
        end
      end
    end
  end
end
