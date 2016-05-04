class Module
  def create_finder_methods(*attributes)
    attributes.each do |attribute|
      new_method = %Q{
        def self.find_by_#{attribute} val
          products = self.all.select{|data| data.#{attribute} == val}
          products.first
        end
      }
      class_eval new_method
    end
  end
end
