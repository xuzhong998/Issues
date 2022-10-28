/* Utils.em - a small collection of useful editing macros */



/*-------------------------------------------------------------------------
	I N S E R T   H E A D E R

	Inserts a comment header block at the top of the current function. 
	This actually works on any type of symbol, not just functions.

	To use this, define an environment variable "MYNAME" and set it
	to your email name.  eg. set MYNAME=raygr
-------------------------------------------------------------------------*/
macro InsertHeader()
{
	/* 获取光标所在行 */
    handle = GetCurrentWnd()
    process_line = GetWndSelLnFirst(handle)

    /* 获取函数所在行文本 */
    file_txt = GetCurrentBuf()
    process_txt = GetBufLine(file_txt,process_line + 1)
    process_txt_len = strlen(process_txt)

    if(process_txt == "")
    {
        stop
    }

    /* 获取函数名 */
    symbol_rec = GetSymbolLocationFromLn (handle, process_line + 1)
    if(symbol_rec == "")
    {
        stop
    }

    fuction_name = symbol_rec.Symbol

    /* 获取参数个数及参数名           */
    param_num = 0
    param_list = SymListNew()

    i=0,j=0
    while(i < process_txt_len)
    {
        if(process_txt[i] == "," || process_txt[i] == ")")
        {
            j = i
            while(j > 0)
            {
                if(process_txt[j] == " " || process_txt[j] == "*" || process_txt[j] == "&" ||
                   process_txt[j] == "(")
                {
                    symbol_rec.Symbol = strmid(process_txt,j+1,i)
                    SymListInsert(param_list,param_num,symbol_rec)
                    param_num = param_num + 1
                    break;
                }
                j = j - 1
            }
        }

        i = i + 1
    }

    /* 输出注释 */
    PutBufLine(handle,process_line + 0,"/*******************************************************************************")

    var temp_buffer
    temp_buffer = cat("  * \@FunctionName: ",fuction_name)
    InsBufLine(handle,process_line + 1,temp_buffer)

    InsBufLine(handle,process_line + 2,"  * \@Author:       ")

    sys_time = GetSysTime(1)
    temp_buffer = "  * \@DateTime:     "
    temp_buffer = cat(temp_buffer,sys_time.date)
    temp_buffer = cat(temp_buffer,"T")
    temp_buffer = cat(temp_buffer,sys_time.time)
    temp_buffer = cat(temp_buffer,"+0800")

    InsBufLine(handle,process_line + 3,temp_buffer)
	InsBufLine(handle,process_line + 4,"  * \@Purpose:      ")
    param_line = process_line + 5
    InsBufLine(handle,param_line,"*******************************************************************************/")

    if(strmid(process_txt,0,4) != "void")
    {
        InsBufLine(handle,param_line,"  * \@return:")
    }

    while(param_num > 0)
    {
        param_num = param_num - 1
        symbol_rec = SymListItem(param_list,param_num)

        temp_buffer = "  * \@param:        "
        temp_buffer = cat(temp_buffer,symbol_rec.Symbol)

        temp_buffer_len = strlen(temp_buffer)
        temp_buffer_len = 38 - temp_buffer_len
        while(temp_buffer_len > 0)
        {
            temp_buffer_len = temp_buffer_len - 1
            temp_buffer = cat(temp_buffer," ")
        }

        //temp_buffer = cat(temp_buffer,"[description]")
        InsBufLine(handle,param_line,temp_buffer)
    }

    SymListFree(param_list)
}


macro GetFileName(pathName)
{
	nlength = strlen(pathName)
	i = nlength - 1
	name = ""
	while (i + 1)
	{
		ch = pathName[i]
		if ("\\" == "@ch@")
			break
		i = i - 1
	}
	i = i + 1
	while (i < nlength)
	{
		name = cat(name, pathName[i])
		i = i + 1
	}

	return name
}

/* InsertFileHeader:

   Inserts a comment header block at the top of the current function. 
   This actually works on any type of symbol, not just functions.

   To use this, define an environment variable "MYNAME" and set it
   to your email name.  eg. set MYNAME=raygr
*/

macro InsertFileHeader()
{
	//get crrunt time
 	szTime = GetSysTime(1)
 	Day = szTime.Day
 	Month = szTime.Month
 	Year = szTime.Year
 	hbuf = GetCurrentBuf()//申请变量空间，Get a handle to the current file buffer and the name
 	PathName = GetBufName(hBuf)
 	FileName = GetFileName(PathName)

 	hbuf = GetCurrentBuf()
 	InsBufLine(hbuf, 0, "/*******************************************************************************")
 	InsBufLine(hbuf, 1, "  * \@file        @FileName@")
 	InsBufLine(hbuf, 2, "  * \@version     v1.0.0")
 	InsBufLine(hbuf, 3, "  * \@copyright   COPYRIGHT &copy; @Year@ CSG")
 	InsBufLine(hbuf, 4, "  * \@author      ")
 	InsBufLine(hbuf, 5, "  * \@date        @Year@-@Month@-@Day@")
 	InsBufLine(hbuf, 6, "  * \@brief")
 	InsBufLine(hbuf, 7, "  * \@attention")
 	InsBufLine(hbuf, 8, "  * Modification History")
 	InsBufLine(hbuf, 9, "  * DATE         DESCRIPTION")
	InsBufLine(hbuf, 10, "  * ------------------------")
 	InsBufLine(hbuf, 11, "  * - @Year@-@Month@-@Day@")
 	InsBufLine(hbuf, 12,"*******************************************************************************/")
}



// Inserts "Returns True .. or False..." at the current line
macro ReturnTrueOrFalse()
{
	hbuf = GetCurrentBuf()
	ln = GetBufLineCur(hbuf)

	InsBufLine(hbuf, ln, "    Returns True if successful or False if errors.")
}



/* Inserts ifdef REVIEW around the selection */
macro IfdefReview()
{
	IfdefSz("REVIEW");
}


/* Inserts ifdef BOGUS around the selection */
macro IfdefBogus()
{
	IfdefSz("BOGUS");
}


/* Inserts ifdef NEVER around the selection */
macro IfdefNever()
{
	IfdefSz("NEVER");
}


// Ask user for ifdef condition and wrap it around current
// selection.
macro InsertIfdef()
{
	sz = Ask("Enter ifdef condition:")
	if (sz != "")
		IfdefSz(sz);
}

macro InsertCPlusPlus()
{
	IfdefSz("__cplusplus");
}


// Wrap ifdef <sz> .. endif around the current selection
macro IfdefSz(sz)
{
	hwnd = GetCurrentWnd()
	lnFirst = GetWndSelLnFirst(hwnd)
	lnLast = GetWndSelLnLast(hwnd)
	 
	hbuf = GetCurrentBuf()
	InsBufLine(hbuf, lnFirst, "#ifdef @sz@")
	InsBufLine(hbuf, lnLast+2, "#endif /* @sz@ */")
}


// Delete the current line and appends it to the clipboard buffer
macro KillLine()
{
	hbufCur = GetCurrentBuf();
	lnCur = GetBufLnCur(hbufCur)
	hbufClip = GetBufHandle("Clipboard")
	AppendBufLine(hbufClip, GetBufLine(hbufCur, lnCur))
	DelBufLine(hbufCur, lnCur)
}


// Paste lines killed with KillLine (clipboard is emptied)
macro PasteKillLine()
{
	Paste
	EmptyBuf(GetBufHandle("Clipboard"))
}



// delete all lines in the buffer
macro EmptyBuf(hbuf)
{
	lnMax = GetBufLineCount(hbuf)
	while (lnMax > 0)
		{
		DelBufLine(hbuf, 0)
		lnMax = lnMax - 1
		}
}


// Ask the user for a symbol name, then jump to its declaration
macro JumpAnywhere()
{
	symbol = Ask("What declaration would you like to see?")
	JumpToSymbolDef(symbol)
}

	
// list all siblings of a user specified symbol
// A sibling is any other symbol declared in the same file.
macro OutputSiblingSymbols()
{
	symbol = Ask("What symbol would you like to list siblings for?")
	hbuf = ListAllSiblings(symbol)
	SetCurrentBuf(hbuf)
}


// Given a symbol name, open the file its declared in and 
// create a new output buffer listing all of the symbols declared
// in that file.  Returns the new buffer handle.
macro ListAllSiblings(symbol)
{
	loc = GetSymbolLocation(symbol)
	if (loc == "")
		{
		msg ("@symbol@ not found.")
		stop
		}
	
	hbufOutput = NewBuf("Results")
	
	hbuf = OpenBuf(loc.file)
	if (hbuf == 0)
		{
		msg ("Can't open file.")
		stop
		}
		
	isymMax = GetBufSymCount(hbuf)
	isym = 0;
	while (isym < isymMax)
		{
		AppendBufLine(hbufOutput, GetBufSymName(hbuf, isym))
		isym = isym + 1
		}

	CloseBuf(hbuf)
	
	return hbufOutput

}
