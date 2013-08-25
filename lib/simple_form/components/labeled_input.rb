module SimpleForm
  module Components
    module LabeledInput
      extend ActiveSupport::Concern

      included do
        include SimpleForm::Components::Labels
      end

      def labeled_input
        input_html_options[:placeholder] ||= raw_label_text
        nil
      end
    end
  end
end

SimpleForm::Inputs::Base.send :include, SimpleForm::Components::LabeledInput
