module Johnson #:nodoc:
  module SpiderMonkey #:nodoc:
    class Debugger # native
      JSTRAP_ERROR    = 0
      JSTRAP_CONTINUE = 1
      JSTRAP_RETURN   = 2
      JSTRAP_THROW    = 3
      JSTRAP_LIMIT    = 4
      attr_accessor :logger
      def initialize(logger)
        @logger = logger
      end

      def interrupt_handler(bytecode, rval)
        logger.debug("interrupt_handler: #{bytecode}, #{rval}")
        JSTRAP_CONTINUE
      end

      def new_script_hook(filename, linenum)
        logger.debug("new_script_hook: #{filename} #{linenum}")
      end

      def destroy_script_hook
        logger.debug("destroy_script_hook")
      end

      def debugger_handler(bytecode, rval)
        logger.debug("debugger_handler: #{bytecode} #{rval}")
        JSTRAP_CONTINUE
      end

      def source_handler(filename, line_number, str)
        logger.debug("source_handler: #{filename}(#{line_number}): #{str}")
      end

      # +call_hook+ is called before and after script execution.  +before+
      # is +true+ if before, +false+ otherwise.
      def execute_hook(before, ok)
        logger.debug("execute_hook: #{before} #{ok}")
      end

      # +call_hook+ is called before and after a function call.  +before+
      # is +true+ if before, +false+ otherwise.
      def call_hook(before, ok)
        logger.debug("call_hook: #{before} #{ok}")
      end

      def object_hook(object, is_new)
        # FIXME object.to_s breaks for eval... wtf?
        logger.debug("object_hook: #{object.class} #{is_new}")
      end

      # This hook can change the control
      def throw_hook(bytecode, rval)
        logger.debug("throw_hook: #{bytecode} #{rval}")
        JSTRAP_CONTINUE
      end

      def debug_error_hook(message)
        logger.debug("debug_error_hook: #{message}")
      end
    end
  end
end