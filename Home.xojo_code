#tag WebPage
Begin WebPage Home
   AllowTabOrderWrap=   True
   Compatibility   =   ""
   ControlID       =   ""
   Enabled         =   False
   Height          =   667
   ImplicitInstance=   True
   Index           =   -2147483648
   Indicator       =   0
   IsImplicitInstance=   False
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   MinimumHeight   =   400
   MinimumWidth    =   600
   TabIndex        =   0
   Title           =   "JsPanel Example"
   Top             =   0
   Visible         =   True
   Width           =   1012
   _ImplicitInstance=   False
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mName          =   ""
   _mPanelIndex    =   -1
   Begin AttyWebJSPanel Dialog4
      AtPosition      =   ""
      ButtonClose     =   True
      ButtonMaximize  =   True
      ButtonMinimize  =   True
      ButtonNormalize =   False
      ButtonSmallify  =   False
      CancelProgress  =   False
      closeOnBackdrop =   True
      ControlID       =   ""
      DisableDragit   =   False
      Enabled         =   True
      GlobalDialog    =   False
      headerLogo      =   "bi bi-bag-check"
      headerTitle     =   ""
      Height          =   611
      HTMLCode        =   ""
      Index           =   -2147483648
      Indicator       =   0
      isProgress      =   False
      Left            =   751
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      MaximizeOnShow  =   False
      minimizeTo      =   ""
      MinTop          =   0
      MyPosition      =   ""
      Resize          =   True
      Scope           =   2
      TabIndex        =   0
      Tooltip         =   ""
      Top             =   56
      Type            =   ""
      Visible         =   True
      Width           =   261
      _mPanelIndex    =   -1
   End
   Begin CustomWebToolbar1 Toolbar1
      ControlID       =   ""
      Enabled         =   True
      FullWidth       =   True
      Height          =   56
      Index           =   -2147483648
      Indicator       =   0
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Position        =   0
      Scope           =   0
      TabIndex        =   1
      Title           =   ""
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   1012
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Shown()
		  CreateDialog1
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub CreateDialog1()
		  Dialog1 =  new AttyWebJSPanel
		  refTestExample = new Example
		  
		  Dialog1.ButtonClose = False
		  Dialog1.MinTop = Toolbar1.Height
		  Dialog1.Resize = True
		  Dialog1.MyPosition = AttyWebJSPanel.Position.left_bottom
		  Dialog1.AtPosition= AttyWebJSPanel.Position.left_bottom
		  Dialog1.DisableDragit= False
		  Dialog1.headerTitle = "Examples"
		  Dialog1.headerLogo = "bi bi-bag-check"
		  
		  AddHandler Dialog1.Closed, WeakAddressOf RemovejsPanel
		  refTestExample.LockLeft = True
		  refTestExample.LockTop = True
		  refTestExample.EmbedWithin(self,0,0,refTestExample.Width,refTestExample.Height)
		  
		  Dialog1.Top=Dialog1.MinTop
		  Dialog1.Left = 0
		  Dialog1.Height =self.Height-Dialog1.MinTop
		  Dialog1.Width = 450
		  
		  AddControl(Dialog1)
		  
		  Dialog1.Container = refTestExample //trigger RecreateJsPanel
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  if Dialog1 <>nil then
		    Dialog1.Close
		    Dialog1 = nil
		  end if
		  
		  if refTestExample <>nil then
		    refTestExample.Close
		    refTestExample = nil
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RemovejsPanel(_ref as AttyWebJSPanel)
		  if refTestExample <> nil then
		    refTestExample = nil
		  end if 
		  
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = LICENSE AttyWebJSPanel
		The MIT License (MIT)
		
		Copyright (c) 2022 Attilio Punzi
		
		Permission is hereby granted, free of charge, to any person
		obtaining a copy of this software and associated documentation
		files (the "Software"), to deal in the Software without
		restriction, including without limitation the rights to use,
		copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the
		Software is furnished to do so, subject to the following
		conditions:
		
		The above copyright notice and this permission notice shall be
		included in all copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
		EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
		OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
		NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
		HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
		WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
		FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
		OTHER DEALINGS IN THE SOFTWARE.
	#tag EndNote

	#tag Note, Name = LICENSE jspanel
		The MIT License (MIT)
		
		Copyright (c) 2013 - 2022 Stefan Sträßer, info@jspanel.de,  https://jspanel.de/
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in
		all copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
		THE SOFTWARE.
		
		Hiermit wird unentgeltlich jeder Person, die eine Kopie der Software und der
		zugehörigen Dokumentationen (die "Software") erhält, die Erlaubnis erteilt,
		sie uneingeschränkt zu benutzen, inklusive und ohne Ausnahme dem Recht, sie
		zu verwenden, kopieren, ändern, fusionieren, verlegen, verbreiten, unterlizenzieren
		und/oder zu verkaufen, und Personen, die diese Software erhalten, diese Rechte zu
		geben, unter den folgenden Bedingungen:
		
		Der obige Urheberrechtsvermerk und dieser Erlaubnisvermerk sind in allen Kopien
		oder Teilkopien der Software beizulegen.
		
		DIE SOFTWARE WIRD OHNE JEDE AUSDRÜCKLICHE ODER IMPLIZIERTE GARANTIE BEREITGESTELLT,
		EINSCHLIESSLICH DER GARANTIE ZUR BENUTZUNG FÜR DEN VORGESEHENEN ODER EINEM BESTIMMTEN
		ZWECK SOWIE JEGLICHER RECHTSVERLETZUNG, JEDOCH NICHT DARAUF BESCHRÄNKT. IN KEINEM
		FALL SIND DIE AUTOREN ODER COPYRIGHTINHABER FÜR JEGLICHEN SCHADEN ODER SONSTIGE
		ANSPRÜCHE HAFTBAR ZU MACHEN, OB INFOLGE DER ERFÜLLUNG EINES VERTRAGES, EINES DELIKTES
		ODER ANDERS IM ZUSAMMENHANG MIT DER SOFTWARE ODER SONSTIGER VERWENDUNG DER SOFTWARE
		ENTSTANDEN.
		
	#tag EndNote


	#tag Property, Flags = &h0
		Dialog1 As AttyWebJSPanel
	#tag EndProperty

	#tag Property, Flags = &h21
		Private refTestExample As AttyWebContainer
	#tag EndProperty


#tag EndWindowCode

#tag Events Dialog4
	#tag Event
		Sub Opening()
		  me.ButtonClose = False
		  me.MinTop = Toolbar1.Height
		  me.Resize = True
		  me.MyPosition = AttyWebJSPanel.Position.right_bottom
		  me.AtPosition= AttyWebJSPanel.Position.right_bottom
		  me.DisableDragit= False
		  me.headerTitle = "HTML Content"
		  me.headerLogo = "bi bi-code-square"
		  me.HTMLCode= "<h1> JSPanel for Xojo </h1><br><a href='https://xojo.com/'><img src='https://xojo.com/account/mwx/mwx_long.png' alt='made with xojo' width='200' height='75'></a>"
		  
		  me.Top=me.MinTop
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutType"
		Visible=true
		Group="Behavior"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_ImplicitInstance"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
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
		Name="IsImplicitInstance"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabOrderWrap"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
		Name="Indicator"
		Visible=false
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
		Name="LayoutDirection"
		Visible=true
		Group="WebView"
		InitialValue="LayoutDirections.LeftToRight"
		Type="LayoutDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - LeftToRight"
			"1 - RightToLeft"
			"2 - TopToBottom"
			"3 - BottomToTop"
		#tag EndEnumValues
	#tag EndViewProperty
#tag EndViewBehavior
