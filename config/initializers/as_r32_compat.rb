module ActionView
  class LookupContext
    module ViewPaths
      def find_all_templates(name, partial = false, locals = {})
        prefixes.collect do |prefix|
          view_paths.collect do |resolver|
            temp_args = *args_for_lookup(name, [prefix], partial, locals, {})
            temp_args[1] = temp_args[1][0]
            resolver.find_all(*temp_args)
          end
        end.flatten!
      end
    end
  end
end

# Bugfix: building an sti model from an association fails
# https://rails.lighthouseapp.com/projects/8994-ruby-on-rails/tickets/6306-collection-associations-build-method-not-supported-for-sti
# https://github.com/rails/rails/issues/815
# https://github.com/rails/rails/pull/1686
ActiveRecord::Reflection::AssociationReflection.class_eval do
  def klass_with_sti(*opts)
    sti_col = klass.inheritance_column
    if sti_col and (h = opts.first).is_a? Hash and (passed_type = ( h[sti_col] || h[sti_col.to_sym] )) and (new_klass = active_record.send(:compute_type, passed_type)) < klass
      new_klass
    else
      klass
    end
  end
  def build_association(*opts, &block)
    klass_with_sti(*opts).new(*opts, &block)
  end
  def create_association(*opts, &block)
    klass_with_sti(*opts).create(*opts, &block)
  end
end
