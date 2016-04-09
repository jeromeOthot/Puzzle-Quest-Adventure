$imported = {} if $imported.nil?
$imported["TH_ScriptCallTraceback"] = true
#===============================================================================
# ** Rest of the script
#===============================================================================
class Object
  #-------------------------------------------------------------------
  #-----------------------------------------------------------------------------
  # Just based on observed behavior. Script calls only have one argument
  # to eval by default so this should be fine until someone finds a reason to
  # pass in more arguments?
  #-----------------------------------------------------------------------------
  alias :th_script_call_traceback_eval :eval
  def eval(*args)
    if args.size == 1
      th_script_call_traceback_eval(args[0], nil, __FILE__, __LINE__)
    else
      return th_script_call_traceback_eval(*args)
    end
  end
end