module Sunspot #:nodoc:
  module Rails #:nodoc:
    module Adapters
      class ActiveRecordDataAccessor < Sunspot::Adapters::DataAccessor
        def options_for_find
          options = {}
          options[:include] = @include unless @include.blank?
          options[:select]  =  @select unless  @select.blank?
          options
        end
      end
    end
  end
end
