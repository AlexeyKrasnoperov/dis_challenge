class ValidationBuilder
  def initialize(controller)
    @controller = controller
  end

  def validates(*attributes)
    validation = attributes.extract_options!
    @params ||= {}
    @params[attributes] = validation
  end

  def validator
    validations = @params
    controller_name = @controller.name.demodulize.underscore

    Struct.new(*validations.keys.flatten) do
      include ActiveModel::Validations
      @controller_name = controller_name

      def self.model_name
        ActiveModel::Name.new(self, BadRequestError, @controller_name)
      end

      validations.each_pair do |names, validation|
        attr_accessor(*names)
        validates(*names, validation)
      end

      attr_reader :params

      def initialize(params = {})
        @params = params
        members.each do |name|
          send(:"#{name}=", params[name])
        end
      end
    end
  end
end