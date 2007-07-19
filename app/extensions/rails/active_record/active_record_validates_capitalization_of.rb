module ActiveRecord
  
  module ValidatesCapitalizationOf
    
    def self.included(base)
      base.extend ClassMethods
    end
        
    module ClassMethods
      
      def validates_capitalization_of(*method_names)
        options = method_names.pop
        configuration = {:on => (options[:on] || :save)} || {}
        
        casing = options[:casing]
        if casing == 'upper'
          method_names.each do |method_name|
            send(validation_method(configuration[:on])) do |record|
              record.errors.add method_name, "Expected to be upper-case" \
                unless is_upper?(record.send(method_name))
            end            
          end          
        end
        
      end
      
      private
      
      def is_upper?(str)
        /^[^a-z]*$/ =~ str
      end
      
    end
    
  end
  
end
ActiveRecord::Base.send(:include, ActiveRecord::ValidatesCapitalizationOf)