# ********************************* Sections ******************************** #
#    -> General                                                               #
#    -> Alias                                                                 #
#    -> Function                                                              #
#    -> Plugins                                                               #
# *************************************************************************** #



# ********************************* General ********************************* #
set print array-indexes on
set print array on
set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set print elements 0
set print union on
set print symbol-filename on
set print inferior-events on
set print sevenbit-strings off

set editing on
set confirm off
set verbose off

set history save 
set history expansion

set tui active-border-mode bold-standout
#set tui border-kind ascii
set tui border-mode half-standout

set python print-stack full

set auto-load safe-path /
set breakpoint pending auto

# set the default base for numeric input and display. 
set radix 0xa


# ********************************** Alias ********************************** #
alias core-dump     = generate-core-file
alias v             = info locals
alias w             = where
alias st-fokmod     = show follow-fork-mode
alias st-detafok    = show detach-on-fork
alias st-logging    = show logging


# ********************************* Function ********************************* #
define cc
    shell clear
end
document cc
    Clear the screen with a simple command.
end

define ff
    apropos $arg0
end
document ff
    Search for GDB command by PATTERN. Usage: ff <pattern>
end

define lc
    layout src
end
document lc
    Enable layout with source code windows.
end

define mia
    set target-async $arg0
end
document mia
    Show whether MI asynchronous mode is enabled.
end

define nonstop
    set pagination off
    set non-stop on
end
document nonstop
    Enable non-stop mode.
end

define fokmod
    set follow-fork-mode $arg0 
end
document fokmod
    Set fork debug mode. Usage: fokmod <parent | child>
end

define emod
    set follow-exec-mode $arg0 
end
document emod
    Set debugger response to a program call of exec. Usage: emod <new | same> 
end

define detafok
    set detach-on-fork $arg0
end
document detafok
    Set fork detach mode. Usage: detafok <on | off> 
end

define pargv
    show args
end
document pargv
    Print program arguments.
end

define pst
    info stack
end
document pst
    Print call stack.
end

define pf
    info frame
    info args
    info locals
end
document pf
    Print stack frame.
end

define pflags
    if (($eflags >> 0xB) & 1 )
        printf "O "
    else
        printf "o "
    end
    
    if (($eflags >> 0xA) & 1 )
        printf "D "
    else
        printf "d "
    end
    
    if (($eflags >> 9) & 1 )
        printf "I "
    else
        printf "i "
    end
    
    if (($eflags >> 8) & 1 )
        printf "T "
    else
        printf "t "
    end
    
    if (($eflags >> 7) & 1 )
        printf "S "
    else
        printf "s "
    end
    
    if (($eflags >> 6) & 1 )
        printf "Z "
    else
        printf "z "
    end
    
    if (($eflags >> 4) & 1 )
        printf "A "
    else
        printf "a "
    end
    
    if (($eflags >> 2) & 1 )
        printf "P "
    else
        printf "p "
    end
    
    if ($eflags & 1)
        printf "C "
    else
        printf "c "
    end
    
    printf "\n"
end
document pflags
    Print flags register.
end

define peflags
    printf "     OF <%d>  DF <%d>  IF <%d>  TF <%d>",\
            (($eflags >> 0xB) & 1 ), (($eflags >> 0xA) & 1 ), \
            (($eflags >> 9) & 1 ), (($eflags >> 8) & 1 )
    printf "  SF <%d>  ZF <%d>  AF <%d>  PF <%d>  CF <%d>\n",\
            (($eflags >> 7) & 1 ), (($eflags >> 6) & 1 ),\
            (($eflags >> 4) & 1 ), (($eflags >> 2) & 1 ), ($eflags & 1)
    printf "     ID <%d>  VIP <%d> VIF <%d> AC <%d>",\
            (($eflags >> 0x15) & 1 ), (($eflags >> 0x14) & 1 ), \
            (($eflags >> 0x13) & 1 ), (($eflags >> 0x12) & 1 )
    printf "  VM <%d>  RF <%d>  NT <%d>  IOPL <%d>\n",\
            (($eflags >> 0x11) & 1 ), (($eflags >> 0x10) & 1 ),\
            (($eflags >> 0xE) & 1 ), (($eflags >> 0xC) & 3 )
end
document peflags
    Print entire eflags register.
end

define preg
    printf "     eax:%08X ebx:%08X  ecx:%08X ",  $eax, $ebx, $ecx
    printf " edx:%08X     eflags:%08X\n",  $edx, $eflags
    printf "     esi:%08X edi:%08X  esp:%08X ",  $esi, $edi, $esp
    printf " ebp:%08X     eip:%08X\n", $ebp, $eip
    printf "     cs:%04X  ds:%04X  es:%04X", $cs, $ds, $es
    printf "  fs:%04X  gs:%04X  ss:%04X    ", $fs, $gs, $ss

    flags
end
document preg
    Print CPU registers.
end

define pfunc
    info functions
end
document pfunc
    Print functions in target.
end

define pvar
    info variables
end
document pvar
    Print variables (symbols) in target.
end

define pso
    info sharedlibrary
end
document pso
    Print shared libraries linked to target.
end

define psig
    info signals
end
document psig
    Print signal actions for target.
end

define pt
    info threads
end
document pt
    Print threads in target.
end

define pinfe
    info inferiors
end
document pinfe
    Print a list of all inferiors currently being managed by gdb. 
end

define pps
    maint info program-spaces
end
document pps
    Print a list of all program spaces currently being managed by gdb.  
end

define disas
    disassemble $arg0
end
document disas
    Disassemble address. Usage: disas <address> 
end

define logging 
    tui disable
    
    set logging $arg0
    set logging overwrite on
    set logging redirect off
end
document logging
    Logging Output. Usage: logging <on | off> 
end


# ********************************* Plugins ********************************* #
#source ~/.stl-views.gdb
source ~/.python.gdb

