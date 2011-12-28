# tweaks to allow Squeel Join

module CanCan
  
  module ModelAdapters
    class ActiveRecordAdapter < AbstractAdapter

      def tableized_conditions(conditions, model_class = @model_class)
        return conditions unless conditions.kind_of? Hash
        conditions.inject({}) do |result_hash, (name, value)|
          reflection_name = name.kind_of?(Symbol) ? name : name._name # Squeel compatibility
          if value.kind_of? Hash
            reflection = model_class.reflect_on_association(reflection_name)
            association_class = reflection.class_name.constantize
            name = reflection.table_name.to_sym
            value = tableized_conditions(value, association_class)
          end
          result_hash[name] = value
          result_hash
        end
      end
      
      private
      
      # override to fix overwrites
      # do not write existing hashes using empty hashes
      def merge_joins(base, add)
        add.each do |name, nested|
          if base[name].is_a?(Hash) && nested.present?
            merge_joins(base[name], nested)
          elsif !base[name].is_a?(Hash) || nested.present?
            base[name] = nested
          end
        end
      end

    end
  end
  
  class Rule
    # allow Squeel Join
    def matches_conditions_hash?(subject, conditions = @conditions)
      if conditions.empty?
        true
      else
        if model_adapter(subject).override_conditions_hash_matching? subject, conditions
          model_adapter(subject).matches_conditions_hash? subject, conditions
        else
          conditions.all? do |name, value|
            if model_adapter(subject).override_condition_matching? subject, name, value
              model_adapter(subject).matches_condition? subject, name, value
            else
              method_name = name.kind_of?(Symbol) ? name : name._name # Squeel compatibility
              attribute = subject.send(method_name)
              if value.kind_of?(Hash)
                if attribute.kind_of? Array
                  attribute.any? { |element| matches_conditions_hash? element, value }
                else
                  !attribute.nil? && matches_conditions_hash?(attribute, value)
                end
              elsif value.kind_of?(Array) || value.kind_of?(Range)
                value.include? attribute
              else
                attribute == value
              end
            end
          end
        end
      end
    end
  end
  
end
