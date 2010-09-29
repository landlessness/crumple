class IsAThoughtAddOnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "must be a ThoughtAddOn" unless value.is_a?(ThoughtAddOn)
  end
end
