
#using the meta programming concepts created a find_by_name and find_by_value methods
class Module

	def create_find_by
		attributes = {:brand => "product[1]", :name => "product[2]"} #hash for attributes
    	attributes.each do |k, v|
      		find_by = %Q{
        		def find_by_#{k}(arg)
        		data = Product.all 
          		data.each do |product|
            		if #{v} == arg
              			return Product.new(id: product[0], brand: product[1], name: product[2], price: product[3].to_f)
            		end
          		end
        	end
      		}
      		class_eval(find_by) 
    	end
  	end
  	create_find_by
	end