#tag Class
Class AttyWebJSPanel
Inherits WebSDKUIControl
	#tag Event
		Sub DrawControlInLayoutEditor(g as graphics)
		  If BooleanProperty("enabled") = False Then
		    g.Transparency = 60
		  Else
		    g.Transparency = 0
		  End If
		  
		  If BooleanProperty("visible") = True Then
		    Var p As picture = PictureConstant("LibraryIcon")
		    g.DrawPicture p, g.Width/2-p.Width/2, g.Height/2-p.Height/2, p.Width, p.Height
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function ExecuteEvent(name as string, parameters as JSONItem) As Boolean
		  select case Name
		  Case "DialogLoaded"
		    
		    if Parameters.HasKey("top") AND Parameters.HasKey("left") AND Parameters.HasKey("width") AND Parameters.HasKey("height") then
		      me.Top = val(Parameters.Value("top").StringValue.Replace("px","").Replace("calc(","").Replace(")",""))
		      me.Left = val(Parameters.Value("left").StringValue.Replace("px","").Replace("calc(","").Replace(")",""))
		      me.Width = val(Parameters.Value("width").StringValue.Replace("px",""))
		      me.Height= val(Parameters.Value("height").StringValue.Replace("px",""))
		    end if 
		    
		    if CurrentStatus <> "smallified" then 
		      if mContainer <> nil then
		        mContainer.Width = self.width
		        mContainer.Height = self.height-34
		        mContainer.FireResize
		      end if 
		    end if 
		    
		    RaiseEvent DialogLoaded
		    
		    if MaximizeOnShow then
		      maximize()
		    end if 
		    
		  case "CancelProgress"
		    RaiseEvent CancelProgress
		  case "onclosed"
		    
		    CurrentStatus = "Closed"
		    var statusBefore as String
		    if Parameters.HasKey("statusBefore") then
		      statusBefore = Parameters.Value("statusBefore").StringValue
		    end if
		    
		    if statusBefore<>"refresh" then
		      
		      if mContainer <>Nil then
		        var closedByUser as Boolean =  False
		        
		        if Parameters.HasKey("closedByUser") then
		          closedByUser = Parameters.Value("closedByUser").BooleanValue
		        end if
		        
		        mContainer.fnUpdateDataDialog = nil
		        mContainer.fnCloseDialog = nil
		        mContainer.Close
		      end if 
		      
		      self.Close
		      
		      self.Destructor
		      
		    end if
		    
		  case "onclosedFiglio"
		    
		    var idFiglio as String 
		    if Parameters.HasKey("controlID") then
		      
		      idFiglio = Parameters.Value("controlID").StringValue
		      
		      for i as integer = 0 to DockContainer.ubound
		        if DockContainer(i).ControlID = idFiglio then
		          DockContainer(i).Close
		          DockContainer(i) = nil
		          DockContainer.RemoveAt(i)
		        end if 
		      next
		      
		    else
		      Break
		    end if 
		    
		  case "resize","drag","onstatuschange"
		    
		    if Name = "onstatuschange" AND Parameters.HasKey("status") then
		      CurrentStatus = Parameters.Value("status").StringValue
		      RaiseEvent onstatuschange(CurrentStatus)
		    end if 
		    
		    
		    if CurrentStatus <> "smallified" AND CurrentStatus <>"minimized" then 
		      
		      if Parameters.HasKey("top") AND Parameters.HasKey("left") AND Parameters.HasKey("width") AND Parameters.HasKey("height") then
		        var topR as Integer = val(Parameters.Value("top").StringValue.Replace("px","").Replace("calc(","").Replace(")",""))
		        var leftR as Integer = val(Parameters.Value("left").StringValue.Replace("px","").Replace("calc(","").Replace(")",""))
		        var widthR as Integer = val(Parameters.Value("width").StringValue.Replace("px",""))
		        var heightR as Integer = val(Parameters.Value("height").StringValue.Replace("px",""))
		        
		        
		        if leftR < 0 then
		          leftR = self.Left
		        end if 
		        
		        me.Left = leftR
		        me.Width = widthR
		        
		        if topR <MinTop then
		          me.Top = MinTop
		          DoReposition
		        else
		          me.Height = heightR
		          me.Top = topR
		        end if 
		        
		        if mContainer <> nil then
		          
		          if mContainer.Width <> widthR OR  mContainer.Height <> heightR then
		            
		            mContainer.OldWidth = mContainer.Width
		            mContainer.Oldheight = mContainer.Height 
		            
		            mContainer.Width = me.Width
		            mContainer.Height = me.Height-34
		            
		            mContainer.FireResize
		          end if
		          
		        end if 
		        
		      end if 
		      
		    end if 
		    
		  case "clickbtn"
		    if Parameters.HasKey("idDialog") AND Parameters.HasKey("risposta")  then
		      var idDialog as String = Parameters.Value("idDialog").StringValue
		      var risposta as String = Parameters.Value("risposta").StringValue
		      
		      for i as integer = 0 to ListaMSG.Ubound
		        var e as AttyWebYesOrNOMSG = ListaMSG(i)
		        if e.ID = idDialog then
		          try 
		            e.fnDelegationResponse.Invoke(idDialog, risposta)
		            e.fnDelegationResponse = nil
		            e.Destructor
		            ListaMSG.RemoveAt(i)
		          catch err as NilObjectException
		          end try
		          exit
		        end if 
		        
		      next
		    end if 
		    
		  end select
		End Function
	#tag EndEvent

	#tag Event
		Function JavaScriptClassName() As String
		  Return "AttyWeb.AttyWebJSPanel"
		End Function
	#tag EndEvent

	#tag Event
		Sub Serialize(js as JSONItem)
		  
		  js.value("enabled") = me.Enabled
		  
		  if isProgress then
		    Type = AttyWebJSPanel.Types.Modal
		    closeOnBackdrop = False
		    ButtonMinimize = False
		    ButtonSmallify = False
		    ButtonNormalize = False
		    ButtonMaximize = False
		    ButtonClose = False
		    DisableDragit = True
		  end if
		  
		  js.value("isProgress") = isProgress
		  
		  if Container<>nil then
		    js.value("IDContainer") = Container.ControlID
		  else
		    js.value("IDContainer") = ""
		  end if 
		  
		  if ParentContainer<>nil then
		    js.value("ParentContainer") = ParentContainer.ControlID
		  else
		    js.value("ParentContainer") = ""
		  end if 
		  
		  js.value("Type") = TypeDialogToString(Type)
		  js.value("HTMLCode") = EncodeBase64(getHTMLSerialize,1)
		  js.value("closeOnBackdrop") =closeOnBackdrop
		  
		  js.value("minimizeTo") =minimizeTo
		  js.value("MyPosition") =PositionTostring(MyPosition)
		  js.value("AtPosition") =PositionTostring(AtPosition)
		  js.value("CancelProgress") =CancelProgress
		  js.value("headerTitle") =EncodeBase64(headerTitle,1)
		  js.value("headerLogo") =headerLogo
		  
		  
		  js.value("ButtonMinimize") =ButtonMinimize
		  js.value("ButtonSmallify") =ButtonSmallify
		  js.value("ButtonNormalize") =ButtonNormalize
		  js.value("ButtonMaximize") =ButtonMaximize
		  js.value("ButtonClose") =ButtonClose
		  
		  
		  js.value("MinTop") =MinTop
		  js.value("Resize") =Resize
		  js.value("Width") =Width
		  js.value("Height") =Height
		  js.value("Top") =Top
		  js.value("Left") =Left
		  js.value("DisableDragit") =DisableDragit
		  
		  
		  var listaDCJSON as new JSONItem
		  var offsetX as integer = 5
		  for each temp as AttyWebContainer in DockContainer
		    
		    var dc as new JSONItem
		    dc.Value("ID") =temp.ControlID
		    dc.value("Width") =temp.Width
		    dc.value("Height") =temp.Height
		    dc.Value("offsetX") = offsetX
		    listaDCJSON.Add(dc)
		    
		    offsetX=offsetX+temp.Width+5
		  next
		  
		  js.value("DockContainer") = listaDCJSON
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function SessionCSSURLs(session as WebSession) As String()
		  if linkCSS.Ubound = -1 then
		    
		    CaricaCSSEsterni
		    
		  end if 
		  
		  Return linkCSS
		End Function
	#tag EndEvent

	#tag Event
		Function SessionJavascriptURLs(session as WebSession) As String()
		  if linkJS.Ubound = -1 then
		    
		    
		    CaricaJSEsterni
		    
		    var AttyWebClassFile as New WebFile
		    AttyWebClassFile.MIMEType = "text/javascript"
		    AttyWebClassFile.Session = Nil
		    AttyWebClassFile.Filename = "AttyWeb.min.js"
		    AttyWebClassFile.Data = JSCLASS
		    
		    FileJS.Append(AttyWebClassFile)
		    linkJS.AddRow(AttyWebClassFile.URL)
		    
		  end if 
		  
		  
		  Return linkJS
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CaricaCSSEsterni()
		  linkCSS.AddRow( "https://cdn.jsdelivr.net/npm/jspanel4@4.16.1/dist/jspanel.css" )
		  linkCSS.AddRow( "https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css" )
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CaricaJSEsterni()
		  linkJS.AddRow( "https://cdn.jsdelivr.net/npm/jspanel4@4.16.1/dist/jspanel.js")
		  linkJS.AddRow( "https://cdn.jsdelivr.net/npm/jspanel4@4.16.1/dist/extensions/modal/jspanel.modal.js")
		  linkJS.AddRow( "https://cdn.jsdelivr.net/npm/jspanel4@4.16.1/dist/extensions/tooltip/jspanel.tooltip.js")
		  linkJS.AddRow("https://cdn.jsdelivr.net/npm/jspanel4@4.16.1/dist/extensions/hint/jspanel.hint.js")
		  linkJS.AddRow( "https://cdn.jsdelivr.net/npm/jspanel4@4.16.1/dist/extensions/layout/jspanel.layout.js")
		  linkJS.AddRow( "https://cdn.jsdelivr.net/npm/jspanel4@4.16.1/dist/extensions/contextmenu/jspanel.contextmenu.js")
		  linkJS.AddRow( "https://cdn.jsdelivr.net/npm/jspanel4@4.16.1/dist/extensions/dock/jspanel.dock.js")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeProgressMSG(_MSG as String)
		  ProgressMSG = _MSG.ReplaceLineEndings("<br>")
		  
		  if Parent isA WebView then
		    Var strExec() as String 
		    strExec.AddRow("try{")
		    strExec.AddRow("var controlObject = XojoWeb.getNamedControl('"+me.ControlID+"');")
		    strExec.AddRow("if(controlObject){")
		    strExec.AddRow("controlObject.ChangeProgressMSG('" + EncodeBase64(ProgressMSG,0) + "');" )
		    strExec.AddRow(  "}")
		    strExec.AddRow(  "} catch(err) {console.log('Error ChangeProgressMSG');}")
		    self.ExecuteJavaScript(String.FromArray( strExec ))
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CloseByContainer()
		  self.Close
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  // Note that this may need modifications if there are multiple constructor choices.
		  // Possible constructor calls:
		  // Constructor() -- From WebSDKUIControl
		  // Constructor() -- From WebUIControl
		  // Constructor() -- From WebControl
		  Super.Constructor
		  Type = AttyWebJSPanel.Types.Palette
		  MyPosition = AttyWebJSPanel.Position.left_top 
		  AtPosition = AttyWebJSPanel.Position.left_top 
		  CurrentStatus = "Normalized"
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub DelegationResponse(_IDDialog as String, _IDbutton as String)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Destructor()
		  if mContainer <> nil then
		    mContainer.fnUpdateDataDialog = nil
		    mContainer.fnCloseDialog = nil
		    mContainer = nil
		  end if
		  
		  
		  ParentContainer = nil
		  
		  if DockContainer<>Nil then
		    DockContainer.RemoveAll
		    DockContainer= nil
		  end if
		  
		  if ListaMSG <>Nil then
		    ListaMSG.RemoveAll
		    ListaMSG = nil
		  end if 
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoReposition()
		  Var strExec() as String 
		  strExec.AddRow("try{")
		  strExec.AddRow("var controlObject = XojoWeb.getNamedControl('"+me.ControlID+"');")
		  strExec.AddRow("if(controlObject && controlObject.ObjJSPanel){")
		  strExec.AddRow("controlObject.ObjJSPanel.reposition();" )
		  strExec.AddRow(  "}")
		  strExec.AddRow(  "} catch(err) {console.log('Error DoReposition');}")
		  self.ExecuteJavaScript(String.FromArray( strExec ))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoResize(_Width as Integer, _Height as integer)
		  me.Width=_Width
		  me.Height=_Height
		  
		  
		  if Container <> nil AND Container.Width <> _Width OR  Container.Height <> _Height then
		    
		    Container.OldWidth = Container.Width
		    Container.Oldheight = Container.Height 
		    
		    Container.Width = width
		    Container.Height = height-34
		    
		    Container.FireResize
		    
		    
		  end if 
		  
		  Var strExec() as String 
		  strExec.AddRow("try{")
		  strExec.AddRow("var controlObject = XojoWeb.getNamedControl('"+me.ControlID+"');")
		  strExec.AddRow("if(controlObject){")
		  strExec.AddRow("controlObject.DoResize(")
		  strExec.AddRow(str(me.Width)+",")
		  strExec.AddRow(str(me.Height)+",")
		  strExec.AddRow(");" )
		  strExec.AddRow(  "}")
		  strExec.AddRow(  "} catch(err) {console.log('Error DoResize');}")
		  self.ExecuteJavaScript(String.FromArray( strExec ))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCurrentStatus() As String
		  Return CurrentStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getHTMLSerialize() As String
		  if isProgress then
		    
		    var HTMLSerialize as String
		    
		    var buttonHTML as String = "<button id='"+me.controlID+"_btnCancelProgress' class='btn' style='margin:3% auto;display:block;font-family: Tahoma; font-size: 12px; "+ _
		    " font-weight: normal; background: var(--color-button-Default); padding: 2%; color: rgb(255, 255, 255); text-transform: none;"+ _
		    " border-width: 1px; border-color: var(--color-button-Border); height: inherit;'><i class='fas fa-times-circle'></i><l> Cancel</l></button>"
		    
		    Type = AttyWebJSPanel.Types.Modal
		    ButtonNormalize= False
		    ButtonMaximize = False
		    ButtonMinimize = False
		    ButtonSmallify = False
		    ButtonClose = False
		    closeOnBackdrop = False
		    MyPosition = AttyWebJSPanel.Position.center
		    HTMLSerialize= "<div class='loader' style='display: table;margin: 0 auto;'></div><div style='text-align: center;padding-top:4%;'>" + _
		    "<p id='"+me.ControlID+"_progText'>"
		    
		    if  ProgressMSG="" then
		      HTMLSerialize=HTMLSerialize+" Loading in progress ..."
		    else
		      HTMLSerialize=HTMLSerialize+ProgressMSG
		    end if
		    
		    
		    
		    HTMLSerialize=HTMLSerialize+"</p></div>"
		    
		    if CancelProgress then
		      HTMLSerialize=HTMLSerialize+buttonHTML
		    end if
		    
		    return HTMLSerialize
		    
		  else
		    
		    return HTMLCode
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Maximize()
		  Var strExec() as String 
		  strExec.AddRow("try{")
		  strExec.AddRow("var controlObject = XojoWeb.getNamedControl('"+me.ControlID+"');")
		  strExec.AddRow("if(controlObject){")
		  strExec.AddRow("controlObject.Maximize();" )
		  strExec.AddRow(  "}")
		  strExec.AddRow(  "} catch(err) {console.log('Error Maximize');}")
		  self.ExecuteJavaScript(String.FromArray( strExec ))
		  
		  CurrentStatus = "Maximized"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Minimize()
		  Var strExec() as String 
		  strExec.AddRow("try{")
		  strExec.AddRow("var controlObject = XojoWeb.getNamedControl('"+me.ControlID+"');")
		  strExec.AddRow("if(controlObject){")
		  strExec.AddRow("controlObject.Minimize();" )
		  strExec.AddRow(  "}")
		  strExec.AddRow(  "} catch(err) {console.log('Error Minimize');}")
		  self.ExecuteJavaScript(String.FromArray( strExec ))
		  CurrentStatus = "Minimized"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Normalize()
		  Var strExec() as String 
		  strExec.AddRow("try{")
		  strExec.AddRow("var controlObject = XojoWeb.getNamedControl('"+me.ControlID+"');")
		  strExec.AddRow("if(controlObject){")
		  strExec.AddRow("controlObject.Normalize();" )
		  strExec.AddRow(  "}")
		  strExec.AddRow(  "} catch(err) {console.log('Error Normalize');}")
		  self.ExecuteJavaScript(String.FromArray( strExec ))
		  CurrentStatus = "Normalized"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PositionTostring(e As AttyWebJSPanel.Position) As String
		  Select Case e
		  Case AttyWebJSPanel.Position.center
		    Return "center"
		  Case AttyWebJSPanel.Position.left_top
		    Return "left-top"
		  Case AttyWebJSPanel.Position.center_top
		    Return "center-top"
		  Case AttyWebJSPanel.Position.right_top
		    Return "right-top"
		  Case AttyWebJSPanel.Position.right_center
		    Return "right-center"
		  Case AttyWebJSPanel.Position.right_bottom
		    Return "right-bottom" 
		  Case AttyWebJSPanel.Position.center_bottom
		    Return "center-bottom"
		  Case AttyWebJSPanel.Position.left_bottom
		    Return "left-bottom"
		  Case AttyWebJSPanel.Position.left_center
		    Return "left-center"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOffset(_offsetX as Integer, _offsetY as Integer)
		  
		  
		  Var strExec() as String 
		  strExec.AddRow("try{")
		  strExec.AddRow("var controlObject = XojoWeb.getNamedControl('"+me.ControlID+"');")
		  strExec.AddRow("if(controlObject && controlObject.ObjJSPanel){")
		  strExec.AddRow("controlObject.ObjJSPanel.reposition({")
		  strExec.AddRow("my: '"+PositionTostring(MyPosition)+"',")
		  strExec.AddRow("at: '"+PositionTostring(AtPosition)+"',")
		  strExec.AddRow("minTop: "+MinTop.ToString+" + 'px',")
		  strExec.AddRow("offsetX: "+_offsetX.ToString+" + 'px',")
		  strExec.AddRow("offsetY: "+_offsetY.ToString+" + 'px'});" )
		  strExec.AddRow("}")
		  strExec.AddRow("} catch(err) {console.log('Error SetOffset');}")
		  self.ExecuteJavaScript(String.FromArray( strExec ))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowHint(_MSG as String = "", tipo as AttyWebJSPanel.MessageTypes)
		  Var HeadIcon as String 
		  if tipo = AttyWebJSPanel.MessageTypes.Success then
		    HeadIcon="<i class='fas fa-check-square'></i>  Success"
		  elseif tipo = AttyWebJSPanel.MessageTypes.Info then
		    HeadIcon="<i class='fas fa-info-circle'></i>  Info"
		  elseif tipo = AttyWebJSPanel.MessageTypes.Warning then
		    HeadIcon="<i class='fa fa-exclamation-circle'></i>  Warning"
		  elseif tipo = AttyWebJSPanel.MessageTypes.Error then
		    HeadIcon= "<i class='fa fa-exclamation-triangle'></i>  Error"
		  end if 
		  
		  Var strExec() as String 
		  strExec.AddRow("try{")
		  strExec.AddRow("var controlObject = XojoWeb.getNamedControl('"+me.ControlID+"');")
		  strExec.AddRow("if(controlObject){")
		  strExec.AddRow("controlObject.ShowHint('" + EncodeBase64(_MSG.ReplaceLineEndings("<br>"), 0) + "',")
		  strExec.AddRow("'"+TypeHintToTheme(tipo)+"'," )
		  strExec.AddRow("'" + EncodeBase64(HeadIcon, 0) + "');")
		  strExec.AddRow("}")
		  strExec.AddRow("} catch(err) {console.log('Error ShowHint');debugger;}")
		  self.ExecuteJavaScript(String.FromArray( strExec ))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowYesOrNo(_msg as AttyWebYesOrNOMSG, tipo as AttyWebJSPanel.MessageTypes)
		  if _msg <> nil then
		    ListaMSG.Append(_msg)
		    Var strExec() as String 
		    strExec.AddRow("try{")
		    strExec.AddRow("var controlObject = XojoWeb.getNamedControl('"+me.ControlID+"');")
		    strExec.AddRow("if(controlObject){")
		    
		    var lista as new JSONItem
		    if _msg.Buttons.Ubound = -1 then
		      
		      //Default yes or no
		      
		      var testo as String = "Yes"
		      var icon as String = "fas fa-check"
		      var butt1 as new JSONItem
		      butt1.Value("Name") = EncodeBase64(ToUTF8(testo), 1)
		      butt1.Value("Caption")=EncodeBase64(ToUTF8(testo), 1)
		      butt1.Value("Icon")= ToUTF8(icon)
		      lista.Add(butt1)
		      
		      
		      testo  = "No"
		      icon  = "fas fa-times-circle"
		      var butt2 as new JSONItem
		      butt2.Value("Name") = EncodeBase64(ToUTF8(testo), 1)
		      butt2.Value("Caption")=EncodeBase64(ToUTF8(testo), 1)
		      butt2.Value("Icon")= ToUTF8(icon)
		      lista.Add(butt2)
		      
		      
		      
		    else
		      
		      for each b as AttyWebAlertButton in _msg.Buttons
		        
		        var butt as new JSONItem
		        butt.Value("Name") = EncodeBase64(ToUTF8(b.Name), 0)
		        butt.Value("Caption")=EncodeBase64(ToUTF8(b.Caption), 0)
		        butt.Value("Icon")=ToUTF8(b.Icon)
		        lista.Add(butt)
		        
		      next
		      
		    end if 
		    
		    strExec.AddRow("controlObject.msgYesorNo('" + _msg.ID + "','" + EncodeBase64(_msg.MSG.ReplaceLineEndings("<br>"), 0) + "','"+TypeMSGToTitle(tipo)+"','"+lista.ToString+"');" )
		    
		    strExec.AddRow(  "}")
		    strExec.AddRow(  "} catch(err) {console.log('Errore YesOrNo Dialog');}")
		    self.ExecuteJavaScript(String.FromArray( strExec ))
		    
		  end if 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToUTF8(s as string) As String
		  if s = "" or s.Encoding = Encodings.UTF8 then
		    return s
		  end if
		  
		  if s.Encoding isA TextEncoding then
		    return s.ConvertEncoding( Encodings.UTF8 )
		  end if
		  
		  //
		  // It's nil
		  //
		  
		  if Encodings.UTF8.IsValidData( s ) then
		    return s.DefineEncoding( Encodings.UTF8 )
		  else
		    return s.DefineEncoding( Encodings.ISOLatin1 ) // Guessing
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function TypeAlertToString(theType as AttyWebJSPanel.MessageTypes) As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function TypeDialogToString(e As AttyWebJSPanel.Types) As String
		  Select Case e
		  Case AttyWebJSPanel.Types.Modal
		    Return "Modal"
		  Case AttyWebJSPanel.Types.Palette
		    Return "Palette"
		  Case AttyWebJSPanel.Types.Hint
		    Return "Hint"
		  Case AttyWebJSPanel.Types.Tooltip
		    Return "Tooltip"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function TypeHintToTheme(e As AttyWebJSPanel.MessageTypes) As String
		  Select Case e
		  Case AttyWebJSPanel.MessageTypes.Success
		    Return "bootstrap-success filled"
		  Case AttyWebJSPanel.MessageTypes.Info
		    Return "bootstrap-info filled"
		  Case AttyWebJSPanel.MessageTypes.Warning
		    Return "bootstrap-warning filled"
		  Case AttyWebJSPanel.MessageTypes.Error
		    Return "bootstrap-danger filled"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function TypeMSGToTitle(e As AttyWebJSPanel.MessageTypes) As String
		  Select Case e
		  Case AttyWebJSPanel.MessageTypes.Success
		    Return "Successo"
		  Case AttyWebJSPanel.MessageTypes.Info
		    Return "Info"
		  Case AttyWebJSPanel.MessageTypes.Warning
		    Return "Avviso"
		  Case AttyWebJSPanel.MessageTypes.Error
		    Return "Errore"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateContainerData(_d as Dictionary)
		  if _d<>nil then
		    
		    if _d.HasKey("headerTitle") then
		      
		      headerTitle = _d.Value("headerTitle").StringValue
		    elseif _d.HasKey("Resize") then
		      
		      if Container <> nil then
		        
		        DoResize(Container.Width,Container.Height+34)
		        
		      end if 
		      
		    elseif _d.HasKey("Stato") then
		      
		      if _d.Value("Stato") = "minimize" then
		        
		        minimize
		      elseif _d.Value("Stato") = "normalize" then
		        normalize
		        
		      elseif _d.Value("Stato") = "maximize" then
		        
		        maximize
		        
		      end if 
		    end if 
		    
		  end if 
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CancelProgress()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DialogLoaded()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event onstatuschange(_stato as String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event YesOrNoClick()
	#tag EndHook


	#tag Property, Flags = &h0
		AtPosition As AttyWebJSPanel.Position
	#tag EndProperty

	#tag Property, Flags = &h0
		ButtonClose As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		ButtonMaximize As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		ButtonMinimize As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		ButtonNormalize As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		ButtonSmallify As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		CancelProgress As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		closeOnBackdrop As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mContainer
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mContainer = value
			  
			  if mContainer <> nil then
			    
			    mContainer.fnUpdateDataDialog = WeakAddressOf UpdateContainerData
			    mContainer.fnCloseDialog = WeakAddressOf CloseByContainer
			    
			  end if
			  
			  me.UpdateControl
			End Set
		#tag EndSetter
		Container As AttyWebContainer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private CurrentStatus As String = "Normalized"
	#tag EndProperty

	#tag Property, Flags = &h0
		DisableDragit As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		DockContainer() As AttyWebContainer
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared FileJS() As WebFile
	#tag EndProperty

	#tag Property, Flags = &h0
		GlobalDialog As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		headerLogo As String = "fad fa-home-heart ml-2"
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mheaderTitle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mheaderTitle = value
			  
			  try
			    
			    Var strExec() as String 
			    strExec.AddRow("try{")
			    strExec.AddRow("var controlObject = XojoWeb.getNamedControl('"+me.ControlID+"');")
			    strExec.AddRow("if(controlObject && controlObject.ObjJSPanel){")
			    strExec.AddRow("controlObject.ObjJSPanel.setHeaderTitle(XojoWeb.DecodeBase64('"+EncodeBase64(mheaderTitle,1)+"'));" )
			    strExec.AddRow(  "}")
			    strExec.AddRow(  "} catch(err) {console.log('Error setHeaderTitle');}")
			    self.ExecuteJavaScript(String.FromArray( strExec ))
			    
			  catch e as NilObjectException
			    
			  end try
			End Set
		#tag EndSetter
		headerTitle As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		HTMLCode As String
	#tag EndProperty

	#tag Property, Flags = &h0
		isProgress As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Shared linkCSS() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Shared linkJS() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ListaMSG() As AttyWebYesOrNOMSG
	#tag EndProperty

	#tag Property, Flags = &h0
		MaximizeOnShow As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContainer As AttyWebContainer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mheaderTitle As String
	#tag EndProperty

	#tag Property, Flags = &h0
		minimizeTo As String
	#tag EndProperty

	#tag Property, Flags = &h0
		MinTop As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		MyPosition As AttyWebJSPanel.Position
	#tag EndProperty

	#tag Property, Flags = &h0
		ParentContainer As AttyWebJSPanel
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ProgressMSG As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Resize As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As AttyWebJSPanel.Types
	#tag EndProperty


	#tag Constant, Name = JSCLASS, Type = String, Dynamic = False, Default = \"var AttyWeb; (function (AttyWeb) {\r\n    try {\r\n\r\n\r\n        AttyWeb.removeAllChildNodes \x3D function removeAllChildNodes(parent) {\r\n            if (parent) {\r\n                while (parent.firstChild) {\r\n                    parent.removeChild(parent.firstChild);\r\n                }\r\n            }\r\n        };\r\n\r\n        AttyWeb.creaPulsante \x3D function creaPulsante(id\x2C Caption\x2C icona\x2C larghezza \x3D \"\"\x2C larghezzaMin \x3D \"\"\x2C altezza \x3D \"\") {\r\n\r\n            let btn \x3D document.createElement(\"button\");\r\n            btn.id \x3D id;\r\n            btn.className \x3D \'btn\';\r\n            btn.style.fontFamily \x3D \"Tahoma\";\r\n            btn.style.fontSize \x3D \"12px\";\r\n            btn.style.fontWeight \x3D \"normal\";\r\n            btn.style.background \x3D \"var(--color-button-Default)\";\r\n            btn.style.padding \x3D \"2px\";\r\n            btn.style.color \x3D \"#FFFFFF\";\r\n            btn.style.textTransform \x3D \"none\";\r\n            btn.style.borderWidth \x3D \"1px\";\r\n            btn.style.borderColor \x3D \"var(--color-button-Border)\";\r\n            //btn.style.lineHeight \x3D \"30px\";\r\n\r\n            if (larghezza !\x3D \'\') {\r\n                btn.style.width \x3D larghezza;\r\n            }\r\n\r\n            if (altezza !\x3D \'\') {\r\n                btn.style.height \x3D altezza;\r\n            } else {\r\n                btn.style.height \x3D \"inherit\";\r\n            }\r\n\r\n            if (larghezzaMin !\x3D \'\') {\r\n                btn.style.minWidth \x3D larghezzaMin;\r\n            }\r\n\r\n            if (icona !\x3D \'\') {\r\n                let icona1 \x3D document.createElement(\"i\");\r\n                icona1.className \x3D icona;\r\n                btn.appendChild(icona1);\r\n            }\r\n\r\n            if (Caption !\x3D \'\') {\r\n                let l1 \x3D document.createElement(\"l\");\r\n                l1.textContent \x3D \' \' + Caption;\r\n                btn.appendChild(l1);\r\n            }\r\n            return btn;\r\n\r\n        };   \r\n\t\t\r\n\t\t\r\n\t            class AttyWebJSPanel extends XojoWeb.XojoVisualControl {\r\n\r\n            constructor(id\x2C events) {\r\n                super(id\x2C events);\r\n                this.ObjJSPanel \x3D null;\r\n                this.ObjDockPanel \x3D [];\r\n            }\r\n\r\n\r\n            ShowHint(MSG\x2C Type\x2C Title) {\r\n\r\n                MSG \x3D XojoWeb.DecodeBase64(MSG);\r\n                Title \x3D XojoWeb.DecodeBase64(Title);\r\n                jsPanel.hint.create({\r\n                    content: \"<p>\" + MSG + \"</p>\"\x2C\r\n                    position: \'right-bottom -5 -5 up\'\x2C\r\n                    contentSize: \'330 auto\'\x2C\r\n                    theme: Type\x2C\r\n                    headerTitle: Title\x2C\r\n                });\r\n            }\r\n\r\n            msgYesorNo(idDialog\x2C msg\x2C tipo\x2C btnList) {\r\n\r\n                let el \x3D this.DOMElement();\r\n                if (!el)\r\n                    return;\r\n\r\n\r\n                const listaBtn \x3D JSON.parse(btnList);\r\n\r\n                //decode msg\r\n                msg \x3D XojoWeb.DecodeBase64(msg);\r\n\r\n                //MSG STRUCTURE\r\n                let modaldialog \x3D document.createElement(\"div\");\r\n                modaldialog.className \x3D \'modal-dialog\';\r\n                modaldialog.style.margin \x3D \"0px\";\r\n\r\n                let modalcontent \x3D document.createElement(\"div\");\r\n                modalcontent.className \x3D \'modal-content\';\r\n\r\n                modaldialog.appendChild(modalcontent);\r\n\r\n                let modalheader \x3D document.createElement(\"div\");\r\n                modalheader.className \x3D \'modal-header\';\r\n                modalheader.style.color \x3D \"#FFF\";\r\n                if (tipo \x3D\x3D \"Info\") {\r\n                    modalheader.style.background \x3D \"#1ba1e2\";\r\n                } else if (tipo \x3D\x3D \"Successo\") {\r\n                    modalheader.style.background \x3D \"#60a917\";\r\n                } else if (tipo \x3D\x3D \"Avviso\") {\r\n                    modalheader.style.background \x3D \"#fa6800\";\r\n                } else if (tipo \x3D\x3D \"Errore\") {\r\n                    modalheader.style.background \x3D \"#ce352c\";\r\n                }\r\n\r\n                modalcontent.appendChild(modalheader);\r\n\r\n\r\n\r\n                let h5header \x3D document.createElement(\"h5\");\r\n                h5header.className \x3D \"modal-title\";\r\n                h5header.textContent \x3D tipo;\r\n\r\n                modalheader.appendChild(h5header);\r\n\r\n                let iheader \x3D document.createElement(\"i\");\r\n                if (tipo \x3D\x3D \"Info\") {\r\n                    iheader.className \x3D \"fas fa-info-circle\";\r\n                } else if (tipo \x3D\x3D \"Successo\") {\r\n                    iheader.className \x3D \"fas fa-check-square\";\r\n                } else if (tipo \x3D\x3D \"Avviso\") {\r\n                    iheader.className \x3D \"fa fa-exclamation-circle\";\r\n                } else if (tipo \x3D\x3D \"Errore\") {\r\n                    iheader.className \x3D \"fa fa-exclamation-triangle\";\r\n                }\r\n\r\n                modalheader.appendChild(iheader);\r\n\r\n\r\n                let modalbody \x3D document.createElement(\"div\");\r\n                modalbody.className \x3D \'modal-body\';\r\n\r\n                modalcontent.appendChild(modalbody);\r\n\r\n                let pbody \x3D document.createElement(\"p\");\r\n                pbody.innerHTML \x3D msg;\r\n\r\n                modalbody.appendChild(pbody);\r\n\r\n\r\n                let modalfooter \x3D document.createElement(\"div\");\r\n                modalfooter.className \x3D \'modal-footer\';\r\n                modalcontent.appendChild(modalfooter);\r\n\r\n                let arraybtn \x3D [];\r\n\r\n                listaBtn.forEach(function (item) {\r\n\r\n                    item.Name \x3D XojoWeb.DecodeBase64(item.Name);\r\n                    item.Caption \x3D XojoWeb.DecodeBase64(item.Caption);\r\n\r\n\r\n                    let btnTemp \x3D AttyWeb.creaPulsante(el.id + \"Button\" + item.Name\x2C item.Caption\x2C item.Icon\x2C \"\"\x2C \"130px\"\x2C \"30px\");\r\n                    btnTemp.name \x3D item.Name;\r\n                    arraybtn.push(btnTemp);\r\n\r\n                    modalfooter.appendChild(btnTemp);\r\n\r\n                });\r\n\r\n                var uuid \x3D Math.random().toString(36).slice(-6);\r\n\r\n                var tempDialog \x3D jsPanel.modal.create({\r\n                    header: false\x2C\r\n                    id: idDialog + el.id + \'_\' + uuid + \'_pan\'\x2C\r\n                    closeOnBackdrop: false\x2C\r\n                    close: \'remove\'\x2C\r\n                    panelSize: {\r\n                        width: modaldialog.width\x2C\r\n                        height: modaldialog.height\x2C\r\n                    }\x2C\r\n                    content: modaldialog\x2C\r\n                });\r\n\r\n\r\n                arraybtn.forEach(function (btn) {\r\n                    btn.addEventListener(\"click\"\x2C function (e) {\r\n                        var jsonObj \x3D new XojoWeb.JSONItem();\r\n                        jsonObj.set(\'idDialog\'\x2C idDialog);\r\n                        jsonObj.set(\'risposta\'\x2C this.name);\r\n                        XojoWeb.session.comm.triggerServerEvent(el.id\x2C \'clickbtn\'\x2C jsonObj);\r\n\r\n                        tempDialog.close();\r\n                        modaldialog.remove();\r\n\r\n                    })\r\n                });\r\n\r\n            }\r\n\r\n\r\n\r\n            Normalize() {\r\n\r\n                if (this.ObjJSPanel) {\r\n                    this.ObjJSPanel.normalize();\r\n                }\r\n\r\n            }\r\n\r\n            Minimize() {\r\n                if (this.ObjJSPanel) {\r\n                    this.ObjJSPanel.minimize();\r\n                }\r\n\r\n            }\r\n\r\n            Maximize() {\r\n\r\n                if (this.ObjJSPanel) {\r\n                    this.ObjJSPanel.maximize();\r\n                }\r\n\r\n            }\r\n\r\n            DoResize(_Width\x2C _Height) {\r\n\r\n                    if (this.ObjJSPanel) {\r\n\r\n                        this.ObjJSPanel.resize({\r\n                            width: _Width + \'px\'\x2C\r\n                            height: _Height + \'px\'\x2C\r\n                        });\r\n                }\r\n\r\n            }\r\n            ChangeProgressMSG(MSG) {\r\n\r\n                let el \x3D this.DOMElement();\r\n                if (!el)\r\n                    return;\r\n\r\n                MSG \x3D XojoWeb.DecodeBase64(MSG);\r\n                document.getElementById(el.id + \"_progText\").innerHTML \x3D MSG;\r\n\r\n            }\r\n\r\n\r\n            CloseAndDestroyJS(reason) {\r\n\r\n                if (!(Object.keys(this.ObjDockPanel).length \x3D\x3D\x3D 0 && this.ObjDockPanel.constructor \x3D\x3D\x3D Object)) {\r\n                    this.ObjDockPanel.forEach(function (dock) {\r\n                        dock.close();\r\n                    });\r\n\r\n                    this.ObjDockPanel \x3D [];\r\n                }\r\n                if (this.ObjJSPanel && this.ObjJSPanel.status !\x3D \'closed\') {\r\n                    this.ObjJSPanel.status \x3D reason;\r\n                    this.ObjJSPanel.close();\r\n                }\r\n                this.ObjJSPanel \x3D null;\r\n            }\r\n\r\n            updateControl(data) {\r\n\r\n                super.updateControl(data);\r\n\r\n                let js \x3D $.parseJSON(data);\r\n\r\n                let el \x3D this.DOMElement();\r\n\r\n\r\n                if (!el)\r\n                    return;\r\n\r\n                jsPanel.ziBase \x3D 100;\r\n\r\n                this.CloseAndDestroyJS(\'refresh\');\r\n\r\n                if (js.isProgress) {\r\n                    XojoWeb.session.comm.triggerServerEvent(el.id\x2C \'DialogLoaded\'\x2C null);\r\n                }\r\n\r\n                if (js.IDContainer !\x3D \'\' || js.HTMLCode !\x3D \'\') {\r\n\r\n                    try {\r\n                        let figlio;\r\n\r\n                        var DialogOpt \x3D {};\r\n                        DialogOpt[\'id\'] \x3D el.id + \'_pan\';\r\n\r\n                        if (js.IDContainer !\x3D \'\') {\r\n                            figlio \x3D document.getElementById(js.IDContainer);\r\n                            if (figlio) {\r\n                                DialogOpt[\'content\'] \x3D figlio;\r\n                            }\r\n                            else {\r\n                                return;\r\n                            }\r\n\r\n                        } else {\r\n                            DialogOpt[\'content\'] \x3D XojoWeb.DecodeBase64(js.HTMLCode);\r\n                        }\r\n\r\n                        if (js.ParentContainer !\x3D \'\') {\r\n                            var ParentObject \x3D XojoWeb.getNamedControl(js.ParentContainer);\r\n                            if (ParentObject) {\r\n                                DialogOpt[\'container\'] \x3D ParentObject.ObjJSPanel.content;\r\n                            }\r\n                        }\r\n\r\n                        if (js.Type \x3D\x3D \"Modal\") {\r\n                            DialogOpt[\'closeOnEscape\'] \x3D false;\r\n                        }\r\n\r\n\r\n                        DialogOpt[\'closeOnBackdrop\'] \x3D js.closeOnBackdrop;\r\n\r\n\r\n                        if (js.minimizeTo !\x3D \"\") {\r\n\r\n                            if (js.minimizeTo !\x3D \"default\" && js.minimizeTo !\x3D \"parent\" && js.minimizeTo !\x3D \"parentpanel\") {\r\n                                DialogOpt[\'minimizeTo\'] \x3D \"#\" + js.minimizeTo;\r\n                            } else {\r\n                                DialogOpt[\'minimizeTo\'] \x3D js.minimizeTo;\r\n                            }\r\n                        }\r\n\r\n\r\n                        if (js.isProgress) {\r\n\r\n                            var panelSize \x3D {};\r\n\r\n                            DialogOpt[\'header\'] \x3D false;\r\n                            DialogOpt[\'position\'] \x3D js.MyPosition;\r\n\r\n                            panelSize[\'width\'] \x3D () \x3D> {\r\n\r\n                                return Math.min(300\x2C window.innerWidth * 0.9);\r\n                            };\r\n\r\n                            if (js.CancelProgress) {\r\n                                panelSize[\'height\'] \x3D () \x3D> {\r\n                                    return Math.min(164\x2C window.innerHeight * 0.6);\r\n                                };\r\n                            } else {\r\n                                panelSize[\'height\'] \x3D () \x3D> {\r\n                                    return Math.min(130\x2C window.innerHeight * 0.6);\r\n                                };\r\n                            }\r\n\r\n                            DialogOpt[\'panelSize\'] \x3D panelSize;\r\n\r\n\r\n                        } else {\r\n                            DialogOpt[\'headerTitle\'] \x3D XojoWeb.DecodeBase64(js.headerTitle);\r\n                            DialogOpt[\'headerLogo\'] \x3D \"<span class\x3D\'\" + js.headerLogo + \"\'></span>\";\r\n\r\n                            var headerControls \x3D {};\r\n                            if (!js.ButtonMinimize) {\r\n                                headerControls[\'minimize\'] \x3D \'remove\';\r\n                            }\r\n                            if (!js.ButtonSmallify) {\r\n                                headerControls[\'smallify\'] \x3D \'remove\';\r\n                            }\r\n                            if (!js.ButtonNormalize) {\r\n                                headerControls[\'normalize\'] \x3D \'remove\';\r\n                            }\r\n                            if (!js.ButtonMaximize) {\r\n                                headerControls[\'maximize\'] \x3D \'remove\';\r\n                            }\r\n                            if (!js.ButtonClose) {\r\n                                headerControls[\'close\'] \x3D \'remove\';\r\n                            }\r\n\r\n                            DialogOpt[\'headerControls\'] \x3D headerControls;\r\n\r\n                            DialogOpt[\'maximizedMargin\'] \x3D [js.MinTop\x2C 5\x2C 5\x2C 5];\r\n                            DialogOpt[\'onwindowresize\'] \x3D js.Resize;\r\n\r\n                            var contentSize \x3D {};\r\n                            contentSize[\'width\'] \x3D js.Width;\r\n                            contentSize[\'height\'] \x3D js.Height;\r\n\r\n                            DialogOpt[\'contentSize\'] \x3D contentSize;\r\n\r\n\r\n                            var position \x3D {};\r\n                            position[\'my\'] \x3D js.MyPosition;\r\n                            position[\'at\'] \x3D js.AtPosition;\r\n                            position[\'minTop\'] \x3D js.MinTop;\r\n                            position[\'offsetX\'] \x3D js.Left + \'px\';\r\n                            position[\'offsetY\'] \x3D js.Top + \'px\';\r\n\r\n                            DialogOpt[\'position\'] \x3D position;\r\n\r\n                            var resizeit \x3D {};\r\n                            resizeit[\'disable\'] \x3D !js.Resize;\r\n                            resizeit[\'stop\'] \x3D (panel\x2C paneldata\x2C event) \x3D> {\r\n                                var jsonObj \x3D new XojoWeb.JSONItem();\r\n                                jsonObj.set(\'top\'\x2C panel.style.top);\r\n                                jsonObj.set(\'left\'\x2C panel.style.left);\r\n                                jsonObj.set(\'width\'\x2C panel.style.width);\r\n                                jsonObj.set(\'height\'\x2C panel.style.height);\r\n                                XojoWeb.session.comm.triggerServerEvent(el.id\x2C \'resize\'\x2C jsonObj);\r\n                            };\r\n\r\n                            DialogOpt[\'resizeit\'] \x3D resizeit;\r\n\r\n\r\n                            var dragit \x3D {};\r\n                            dragit[\'disable\'] \x3D js.DisableDragit;\r\n                            dragit[\'stop\'] \x3D (panel\x2C paneldata\x2C event) \x3D> {\r\n                                var jsonObj \x3D new XojoWeb.JSONItem();\r\n                                jsonObj.set(\'top\'\x2C panel.style.top);\r\n                                jsonObj.set(\'left\'\x2C panel.style.left);\r\n                                jsonObj.set(\'width\'\x2C panel.style.width);\r\n                                jsonObj.set(\'height\'\x2C panel.style.height);\r\n                                XojoWeb.session.comm.triggerServerEvent(el.id\x2C \'drag\'\x2C jsonObj);\r\n                            };\r\n\r\n                            DialogOpt[\'dragit\'] \x3D dragit;\r\n\r\n                        }\r\n\r\n\r\n                        if (!js.isProgress) {\r\n                            DialogOpt[\'onclosed\'] \x3D function (panel\x2C closedByUser) {\r\n                                panel.status \x3D \'closed\';\r\n                                var jsonObj \x3D new XojoWeb.JSONItem();\r\n                                jsonObj.set(\'closedByUser\'\x2C closedByUser);\r\n                                jsonObj.set(\'status\'\x2C panel.status);\r\n                                jsonObj.set(\'statusBefore\'\x2C panel.statusBefore);\r\n                                XojoWeb.session.comm.triggerServerEvent(el.id\x2C \'onclosed\'\x2C jsonObj);\r\n                            };\r\n\r\n                            DialogOpt[\'onstatuschange\'] \x3D function (panel\x2C status) {\r\n                                var jsonObj \x3D new XojoWeb.JSONItem();\r\n                                jsonObj.set(\'top\'\x2C panel.style.top);\r\n                                jsonObj.set(\'left\'\x2C panel.style.left);\r\n                                jsonObj.set(\'width\'\x2C panel.style.width);\r\n                                jsonObj.set(\'height\'\x2C panel.style.height);\r\n                                jsonObj.set(\'status\'\x2C panel.status);\r\n                                XojoWeb.session.comm.triggerServerEvent(el.id\x2C \'onstatuschange\'\x2C jsonObj);\r\n                            };\r\n\r\n                        }\r\n\r\n\r\n                        if (js.Type \x3D\x3D \"Modal\") {\r\n                            this.ObjJSPanel \x3D jsPanel.modal.create(DialogOpt);\r\n                        } else if (js.Type \x3D\x3D \"Palette\") {\r\n                            this.ObjJSPanel \x3D jsPanel.create(DialogOpt);\r\n                        } else if (js.Type \x3D\x3D \"Hint\") {\r\n                            this.ObjJSPanel \x3D jsPanel.hint.create(DialogOpt);\r\n                        } else if (js.Type \x3D\x3D \"Tooltip\") {\r\n                            this.ObjJSPanel \x3D jsPanel.tooltip.create(DialogOpt);\r\n                        }\r\n\r\n\r\n                        if (!(Object.keys(js.DockContainer).length \x3D\x3D\x3D 0 && js.DockContainer.constructor \x3D\x3D\x3D Object)) {\r\n                            var questaclasse \x3D this;\r\n                            js.DockContainer.forEach(function (dc) {\r\n\r\n                                var dockPanel \x3D jsPanel.create({\r\n                                    id: dc.ID + \'_pan\'\x2C\r\n                                    content: document.getElementById(dc.ID)\x2C\r\n                                    theme: \'info\'\x2C\r\n                                    headerTitle: \'\'\x2C\r\n                                    onclosed: function (panel\x2C closedByUser) {\r\n                                        panel.status \x3D \'closed\';\r\n                                        var jsonObj \x3D new XojoWeb.JSONItem();\r\n                                        jsonObj.set(\'controlID\'\x2C dc.ID);\r\n                                        jsonObj.set(\'closedByUser\'\x2C closedByUser);\r\n                                        XojoWeb.session.comm.triggerServerEvent(el.id\x2C \'onclosedFiglio\'\x2C jsonObj);\r\n                                    }\x2C\r\n                                    contentSize: { width: dc.Width + \'px\'\x2C height: dc.Height + \'px\' }\x2C\r\n                                    maximizedMargin: [js.MinTop\x2C 5\x2C 5\x2C 5]\x2C\r\n\r\n                                }).dock({\r\n                                    master: questaclasse.ObjJSPanel\x2C\r\n                                    position: { offsetX: dc.offsetX }\x2C\r\n                                    linkSlaveHeight: false\x2C\r\n                                    linkSlaveWidth: false\x2C\r\n                                });\r\n\r\n                                questaclasse.ObjDockPanel.push(dockPanel);\r\n\r\n                            });\r\n\r\n\r\n                        }\r\n\r\n\r\n\r\n\r\n                        if (!js.isProgress) {\r\n                            var jsonObj \x3D new XojoWeb.JSONItem();\r\n                            if (this.ObjJSPanel) {\r\n                                jsonObj.set(\'top\'\x2C this.ObjJSPanel.style.top);\r\n                                jsonObj.set(\'left\'\x2C this.ObjJSPanel.style.left);\r\n                                jsonObj.set(\'width\'\x2C this.ObjJSPanel.style.width);\r\n                                jsonObj.set(\'height\'\x2C this.ObjJSPanel.style.height);\r\n                            }\r\n                            XojoWeb.session.comm.triggerServerEvent(el.id\x2C \'DialogLoaded\'\x2C jsonObj);\r\n                        }\r\n\r\n                        if (js.CancelProgress) {\r\n                            var button \x3D document.getElementById(el.id + \"_btnCancelProgress\");\r\n                            button.addEventListener(\'click\'\x2C function (event) {\r\n                                XojoWeb.session.comm.triggerServerEvent(el.id\x2C \'CancelProgress\'\x2C null);\r\n                            });\r\n                        }\r\n\r\n\r\n                        if (js.Type \x3D\x3D \"Modal\") {\r\n                            document.getElementById(\'jsPanel-modal-backdrop-\' + el.id + \'_pan\').style.zIndex \x3D 150;\r\n                            document.getElementById(el.id + \'_pan\').style.zIndex \x3D 200;\r\n                        }\r\n\r\n\r\n\r\n\r\n                    } catch (err) {\r\n                        console.log(\'Dialog Error.\');\r\n                    }\r\n                }\r\n\r\n\r\n\r\n                this.refresh();\r\n            }\r\n            close() {\r\n                super.close();\r\n                this.CloseAndDestroyJS(\'closedAndDestroy\');\r\n            }\r\n        }\r\n        AttyWeb.AttyWebJSPanel \x3D AttyWebJSPanel;\r\n\r\n\r\n\t\t} catch (err) { }\r\n\r\n})(AttyWeb || (AttyWeb \x3D {}));", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LibraryIcon, Type = String, Dynamic = False, Default = \"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\x3D", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NavigatorIcon, Type = String, Dynamic = False, Default = \"iVBORw0KGgoAAAANSUhEUgAAABAAAAANCAYAAACgu+4kAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAADtSURBVDhPjZJBSgNBEEWbgAsXcaV7o0EhkCw9g5CbCJKz5Cgu4l3UEBI3caFLt+p7PV0wM0wyfnhM16+qmZ6uTv/QA7zAIkctDcrzmOZwA1c56tE5nFbLLNff8Av3Jb6ATl3CGzzBiQayyWZfcgbm1jCChm7hHSz+gmtQS9B7Br3PEltrT9YM9mBiBxMIvYL+Y46q3Bb0PsDefMIaP3CnUTQGfXEdssZafXvTFLp24Ff13EWocwfKMdlsIs5gVWLPQemZ02ucQag+hSHUx6eczMEphOIe1MfXvhfW9CrG528c1aGrvAFPuOcFKf0Btd5BmD9zzEsAAAAASUVORK5CYII\x3D", Scope = Private
	#tag EndConstant


	#tag Enum, Name = MessageTypes, Flags = &h0
		Info
		  Success
		  Warning
		Error
	#tag EndEnum

	#tag Enum, Name = Position, Flags = &h0
		center
		  left_top
		  center_top
		  right_top
		  right_center
		  right_bottom
		  center_bottom
		  left_bottom
		left_center
	#tag EndEnum

	#tag Enum, Name = Types, Flags = &h0
		Palette
		  Modal
		  Hint
		Tooltip
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="_mPanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="34"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockHorizontal"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockVertical"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ControlID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Visual Controls"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Visual Controls"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Indicator"
			Visible=true
			Group="Visual Controls"
			InitialValue=""
			Type="WebUIControl.Indicators"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Primary"
				"2 - Secondary"
				"3 - Success"
				"4 - Danger"
				"5 - Warning"
				"6 - Info"
				"7 - Light"
				"8 - Dark"
				"9 - Link"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Resize"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonClose"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonMaximize"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonMinimize"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonNormalize"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonSmallify"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CancelProgress"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="closeOnBackdrop"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisableDragit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="headerLogo"
			Visible=false
			Group="Behavior"
			InitialValue="fad fa-home-heart ml-2"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="headerTitle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaximizeOnShow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="minimizeTo"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinTop"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GlobalDialog"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AtPosition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="AttyWebJSPanel.Position"
			EditorType="Enum"
			#tag EnumValues
				"0 - center"
				"1 - left_top"
				"2 - center_top"
				"3 - right_top"
				"4 - right_center"
				"5 - right_bottom"
				"6 - center_bottom"
				"7 - left_bottom"
				"8 - left_center"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="MyPosition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="AttyWebJSPanel.Position"
			EditorType="Enum"
			#tag EnumValues
				"0 - center"
				"1 - left_top"
				"2 - center_top"
				"3 - right_top"
				"4 - right_center"
				"5 - right_bottom"
				"6 - center_bottom"
				"7 - left_bottom"
				"8 - left_center"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="AttyWebJSPanel.Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Palette"
				"1 - Modal"
				"2 - Hint"
				"3 - Tooltip"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTMLCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isProgress"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
