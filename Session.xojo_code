#tag Class
Protected Class Session
Inherits WebSession
#tag Session
  interruptmessage=We are having trouble communicating with the server. Please wait a moment while we attempt to reconnect.
  disconnectmessage=You have been disconnected from this application.
  confirmmessage=
  AllowTabOrderWrap=True
#tag EndSession
	#tag Event
		Sub Opening()
		  '-----------------------NEW ALERT--------------------
		  PageAlert = new WebPage
		  MsgAlertAtty = new AttyWebJSPanel
		  PageAlert.AddControl(MsgAlertAtty)
		End Sub
	#tag EndEvent

	#tag Event
		Sub PreparingSession(ByRef HTMLHeader as String)
		  Dim source() As String
		  source.Append("<style type='text/css'>")
		  source.Append(":root {")
		  source.Append("--primary: #222;")
		  source.Append("--secondary: #fff;")
		  source.Append("--color-button-Default: #DC5612;")
		  source.Append("--color-button-Border: #313131;")
		  source.Append("--color-button-Override: #ff5722;")
		  source.Append("--color-Logo-Scuro: #912414;")
		  source.Append("--color-Logo-Chiaro: #e25514;")
		  source.Append("}")
		  
		  source.Append("html {")
		  source.Append("color: var(--primary);")
		  source.Append("background-color: var(--secondary);")
		  source.Append("}")
		  
		  
		  source.Append(".btn-primary {")
		  source.Append("color: #fff !important;")
		  source.Append("background-color: var(--color-button-Default) !important;")
		  source.Append("border-color: var(--color-button-Default) !important;")
		  source.Append("}")
		  source.Append(".btn-primary:not(:disabled):not(.disabled).active, .btn-primary:not(:disabled):not(.disabled):active, .show>.btn-primary.dropdown-toggle {")
		  source.Append("color: #fff!important;")
		  source.Append("background-color: var(--color-button-Override) !important;")
		  source.Append("border-color: var(--color-button-Override) !important;")
		  source.Append("}")
		  
		  
		  source.Append(".jsPanel {")
		  source.Append("font-family: inherit !important;")
		  source.Append("}")
		  
		  
		  source.Append(".jsPanel-content {")
		  source.Append("overflow: inherit !important;")
		  source.Append("}")
		  
		  source.Append(".jsPanel-replacement {")
		  source.Append("width: fit-content !important;")
		  source.Append("}")
		  
		  source.Append(".jsPanel .jsPanel-content {")
		  source.Append("font-family: inherit !important;")
		  source.Append("}")
		  
		  source.Append(".loader {")
		  source.Append("border: 10px solid var(--color-Logo-Scuro); ")
		  source.Append("border-top: 10px solid var(--color-Logo-Chiaro); ")
		  source.Append("margin-top: 6% !important;")
		  source.Append("border-radius: 50%;")
		  source.Append("width: 60px;")
		  source.Append("height: 60px;")
		  source.Append("animation: spin 2s linear infinite;")
		  source.Append("}")
		  
		  source.Append("@keyframes spin {")
		  source.Append("0% { transform: rotate(0deg); }")
		  source.Append("100% { transform: rotate(360deg); }")
		  source.Append("}")
		  
		  source.Append("</style>")
		  
		  HTMLHeader=HTMLHeader+Join(source,"")
		  
		End Sub
	#tag EndEvent


	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub BlankDelegate()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Destructor()
		  MsgAlertAtty = nil
		  
		  PageAlert = nil
		  
		  Processes = nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoProcc_FineCaricamento(p as AttyWebJSPanel)
		  var ecc as Boolean = False
		  
		  try
		    
		    Processes.invoke
		    
		  catch e as UnsupportedFormatException
		  catch e as NilObjectException
		  catch e as TypeMismatchException 
		  catch e as OutOfBoundsException
		  Catch ex as RuntimeException
		    
		  end Try
		  
		  
		  if ecc then
		    MsgAlertAtty.ShowHint("Error ", AttyWebJSPanel.MessageTypes.Error)
		  end if
		  
		  RemoveHandler p.DialogLoaded,WeakAddressOf DoProcc_FineCaricamento
		  
		  p.Close
		  p=nil
		  
		  Processes=nil
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoProcesses(_Processes as Session.BlankDelegate)
		  me.Processes = _Processes
		  
		  
		  try 
		    var  ProgressDialog as new AttyWebJSPanel
		    ProgressDialog.isProgress = True
		    AddHandler ProgressDialog.DialogLoaded,WeakAddressOf DoProcc_FineCaricamento
		    PageAlert.AddControl(ProgressDialog)
		    
		  catch e as RuntimeException
		    //If it gives error it means it doesn't star the dialog so I proceed without showing progress
		    Processes.invoke
		    
		  end Try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowYesorNoAtty(_msg as AttyWebYesOrNOMSG, tipo as AttyWebJSPanel.MessageTypes)
		  MsgAlertAtty.ShowYesOrNo(_msg,tipo)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		MsgAlertAtty As AttyWebJSPanel
	#tag EndProperty

	#tag Property, Flags = &h0
		PageAlert As WebPage
	#tag EndProperty

	#tag Property, Flags = &h0
		Processes As BlankDelegate
	#tag EndProperty


	#tag ViewBehavior
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
			Name="HashTag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Identifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageRightToLeft"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RemoteAddress"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScaleFactor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UserTimeout"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="URL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_baseurl"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisconnectMessage"
			Visible=true
			Group="Behavior"
			InitialValue="You have been disconnected from this application."
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InterruptionMessage"
			Visible=true
			Group="Behavior"
			InitialValue="We are having trouble communicating with the server. Please wait a moment while we attempt to reconnect."
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_LastMessageTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabOrderWrap"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConfirmDisconnectMessage"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Platform"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsDarkMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClientHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClientWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
