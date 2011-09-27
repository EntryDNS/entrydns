class DomainsController < ApplicationController
  
  active_scaffold :domain do |conf|
    conf.columns = [:name, :soa_record, :ns_records, :records]
    conf.list.columns = [:name, :soa_record, :ns_records, :records]
    conf.create.columns = [:name, :soa_record, :ns_records]
    conf.update.columns = [:name, :soa_record, :ns_records]
    conf.actions.exclude :show
    conf.list.sorting = { :name => :asc }
    
    conf.columns[:records].label = 'All Records'
  end
  
  protected
    
  def before_create_save(record)
    record.type = 'NATIVE'
  end
  
  # TODO: move to core
  def do_edit_associated
    @parent_record = params[:id].nil? ? new_model : find_if_allowed(params[:id], :update)
    @column = active_scaffold_config.columns[params[:association]]

    # NOTE: we don't check whether the user is allowed to update this record, because if not, we'll still let them associate the record. we'll just refuse to do more than associate, is all.
    @record = @column.association.klass.find(params[:associated_id]) if params[:associated_id]
    @record ||= @column.singular_association? ? @parent_record.send(:"build_#{@column.name}") : @parent_record.send(@column.name).build
    reflection = @parent_record.class.reflect_on_association(@column.name)
    if reflection && reflection.reverse
      reverse_macro = @record.class.reflect_on_association(reflection.reverse).macro
      @record.send(:"#{reflection.reverse}=", @parent_record) if [:has_one, :belongs_to].include?(reverse_macro)
    end
    
    @scope = "[#{@column.name}]"
    @scope += (@record.new_record?) ? "[#{(Time.now.to_f*1000).to_i.to_s}]" : "[#{@record.id}]" if @column.plural_association?
  end
  
end
