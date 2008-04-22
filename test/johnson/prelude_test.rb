require File.expand_path(File.join(File.dirname(__FILE__), "/../helper"))

module Johnson
  class PreludeTest < Johnson::TestCase
    def setup
      @context = Johnson::Context.new
    end
    
    def test_symbols_are_interned
      assert(@context.evaluate("Johnson.symbolize('foo') === Johnson.symbolize('foo')"))
    end

    def test_symbol_to_string
      assert_equal("monkey", @context.evaluate("Johnson.symbolize('monkey').toString()"))
    end

    def test_symbol_inspect
      assert_equal(":monkey", @context.evaluate("Johnson.symbolize('monkey').inspect()"))
    end
    
    def test_all_of_ruby_is_available
      assert_raise(Johnson::Error) { @context.evaluate("Ruby.Set.new()") }
      
      @context.evaluate("Ruby.require('set')")
      assert_kind_of(Set, @context.evaluate("Ruby.Set.new()"))
    end
    
    def test_require_an_existing_js_file_without_extension
      assert_js("Johnson.require('johnson/template')")
    end
    
    def test_require_returns_false_the_second_time_around
      assert_js("Johnson.require('johnson/template')")
      assert(!@context.evaluate("Johnson.require('johnson/template')"))
    end
    
    def test_missing_requires_throw_LoadError
      assert_js(<<-END)
        var flag = false;
        
        try { Johnson.require("johnson/__nonexistent"); }
        catch(FileNotFound) { flag = true; }
        
        flag;
      END
    end
  end
end
