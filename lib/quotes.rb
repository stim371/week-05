# 
# Here is where you will write the class Quotes
# 
# For more information about classes I encourage you to review the following:
# 
# @see http://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Classes
# @see Programming Ruby, Chapter 3
# 
# 
# For this exercise see if you can employ the following techniques:
# 
# Use class convenience methods: attr_reader; attr_writer; and attr_accessor.
# 
# Try using alias_method to reduce redundancy.
# 
# @see http://rubydoc.info/stdlib/core/1.9.2/Module#alias_method-instance_method
# 
class Quotes
  attr_accessor :file, :quotes
  alias_method :all, :quotes
    
  class << self
    attr_accessor :missing_quote
    
    def missing_quote
      @missing_quote || "Could not find a quote at this time"
    end
    
    def load filename
      self.new(:file => filename)
    end
  end
  
  #self.missing_quote = "Could not find a quote at this time"
  
  def initialize params
    @file   = params[:file]  
    @quotes = File.exists?(@file) ? File.readlines(@file).map { |quote| quote.strip } : []
  end
  
  def find line_number
    @quotes.empty? ? Quotes.missing_quote : line_number >= @quotes.size ? @quotes.sample : @quotes[line_number]
  end
  
  alias_method :[], :find
  
  def search fileinfo = {}
    results =  fileinfo.map { |search_pair| @quotes.select { |line| line =~ search_string(*search_pair) }}.flatten
    results.empty? ? @quotes : results
  end

  def search_string crit, val
    regexhash = {:start_with => /^#{val}/, :include => /#{val}/, :end_with => /#{val}$/}

    myregex = Regexp.new(regexhash[crit])
    myregex
  end
  
end