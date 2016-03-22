
#using the meta programming concepts created a find_by_name and find_by_value methods
class Module

	def find_by_namebrand
		name_brand_hash = {:brand => "brand", :name => "name"} #hash for attributes
    	name_brand_hash.each do |k, v|
      		find_by = %Q{
        		def find_by_#{k}(arg)
        		data = Product.all 
          		data.each do |product_arr|
            		if #{v} == arg
              			return Product.new(id: product_arr[0], brand: product_arr[1], name: product_arr[2], price: product_arr[3].to_f)
            		end
          		end
        	end
      		}
      		class_eval(find_by) 
    	end
  	end
  	find_by_namebrand
	end