require "nice/diff/version"
require "nice/diff/parser"

module Nice
  class Diff
    # Error raised if the specified file cannot be found.
     class FileDoesNotExist < RuntimeError; end

	# Error raised if the format is not specified.
    class FormatNotSpecified < RuntimeError; end

   	attr_accessor :format, :expected_file, :actual_file
    	
    @@hash_print = nil
    @@key = nil

    def initialize(format, expected_file, actual_file)    		
    	raise Nice::Diff::FileDoesNotExist unless File.exists?(expected_file)
    	raise Nice::Diff::FileDoesNotExist unless File.exists?(actual_file)
    	raise Nice::Diff::FormatNotSpecified if format.nil?
    		
    	@expected_file = File.read expected_file
    	@actual_file = File.read actual_file
		@format = format.upcase
    end

    def parse_to_array    		
    	parser = eval("#{@format}Parser").new
		parser.parse_to_array(self) #passing reference to itself to the parsing strategy
    end

    def self.hash_print
    	@@hash_print
    end

    def key=(key)
    	@@key = key
    end

	def print
		expected_arr, actual_arr = parse_to_array
		headers = Array.new     

		expected_arr.each_with_index { |expected_hash_of_obj, i|
		expected_arr[0].each_with_index { |(k,v), i| headers[i] = k} 
		actual_hash_of_obj = actual_arr[i]      

		expected_keys = expected_hash_of_obj.keys.to_set
		actual_keys = actual_hash_of_obj.keys.to_set

		unless expected_keys == actual_keys
			unwanted = actual_keys - expected_keys
			missing = expected_keys - actual_keys

			STDOUT.puts "\Actual #{@format} file contain #{unwanted.size} unwanted #{@@key}(s): #{actual_hash_of_obj.keys - expected_hash_of_obj.keys}" unless unwanted.empty?
			STDOUT.puts "\Actual #{@format} file is missing #{missing.size} #{@@key}(s): #{expected_hash_of_obj.keys - actual_hash_of_obj.keys}" unless missing.empty?
			return
			end

			unless expected_hash_of_obj.eql?(actual_hash_of_obj) 
				STDOUT.puts "\nDiff for object\##{i}:\n"
				self.class.print_hash_diff(expected_hash: expected_hash_of_obj, actual_hash: actual_hash_of_obj, headers: headers)
			end
		}	
	end

	private
	def self.print_hash_diff(expected_hash: nil, actual_hash: nil, headers: nil)   
		@@hash_print = Hash.new

		expected_hash.each_with_index { |(k,v), i|       
			unless v.eql?(actual_hash[k])
				@@hash_print["#{i}"] = actual_hash[k]
			end
		}

		headers.keep_if { |i| @@hash_print.keys.include?(headers.index(i).to_s)}
		offset1 = headers.max_by(&:length).length + 10
		offset2 = expected_hash.values.compact.max_by(&:length).length + 10
		offset3 = @@hash_print.values.compact.max_by(&:length).length + 10
    
		STDOUT.puts "\t| #{@@key}:".ljust(offset1) + "| Expected:".ljust(offset2) + "| Actual:".ljust(offset3) + "|"
		@@hash_print.each_with_index { |(k,v), i|
		STDOUT.puts "\t| #{headers[i]}".ljust(offset1) + "| #{expected_hash[expected_hash.keys[k.to_i]]}".ljust(offset2) + "| #{@@hash_print[k]}".ljust(offset3) + "|"
		}
	end
  end
end
