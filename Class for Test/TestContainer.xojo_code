#tag WebContainerControl
Begin AttyWebContainer TestContainer
   Compatibility   =   ""
   ControlID       =   ""
   Enabled         =   True
   Height          =   458
   Indicator       =   0
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   ScrollDirection =   0
   TabIndex        =   0
   Top             =   0
   Visible         =   True
   Width           =   620
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mName          =   ""
   _mPanelIndex    =   -1
   Begin WebImageViewer ImageViewer1
      ControlID       =   ""
      Enabled         =   True
      Height          =   128
      HorizontalAlignment=   2
      Index           =   -2147483648
      Indicator       =   0
      Left            =   9
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Picture         =   0
      Scope           =   2
      SVGData         =   ""
      TabIndex        =   0
      Tooltip         =   ""
      Top             =   7
      URL             =   ""
      VerticalAlignment=   2
      Visible         =   True
      Width           =   128
      _mPanelIndex    =   -1
      _ProtectImage   =   False
   End
   Begin WebButton Button1
      AllowAutoDisable=   False
      Cancel          =   True
      Caption         =   "Cancel"
      ControlID       =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   172
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   2
      TabIndex        =   1
      Tooltip         =   ""
      Top             =   7
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebButton Button2
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "OK"
      ControlID       =   ""
      Default         =   True
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   1
      Left            =   172
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   2
      TabIndex        =   2
      Tooltip         =   ""
      Top             =   53
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebPopupMenu PopupMenu1
      ControlID       =   ""
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   ""
      LastAddedRowIndex=   0
      LastRowIndex    =   0
      Left            =   346
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      RowCount        =   0
      Scope           =   2
      SelectedRowIndex=   0
      SelectedRowValue=   ""
      TabIndex        =   3
      Tooltip         =   ""
      Top             =   7
      Visible         =   True
      Width           =   254
      _mPanelIndex    =   -1
   End
   Begin WebTextArea TextArea1
      AllowReturnKey  =   True
      AllowSpellChecking=   False
      Caption         =   ""
      ControlID       =   ""
      Enabled         =   True
      Height          =   232
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   4
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   149
      Visible         =   True
      Width           =   580
      _mPanelIndex    =   -1
   End
   Begin WebSearchField SearchField1
      ControlID       =   ""
      Enabled         =   True
      Height          =   38
      Hint            =   "Search"
      Index           =   -2147483648
      Indicator       =   0
      Left            =   346
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Scope           =   2
      TabIndex        =   5
      Text            =   ""
      Tooltip         =   ""
      Top             =   63
      Visible         =   True
      Width           =   254
      _mPanelIndex    =   -1
   End
   Begin WebRectangle Rectangle1
      BackgroundColor =   &cFFFFFF00
      ControlID       =   ""
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   57
      Index           =   -2147483648
      Indicator       =   0
      LayoutDirection =   0
      LayoutType      =   0
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Scope           =   0
      TabIndex        =   6
      Tooltip         =   ""
      Top             =   401
      Visible         =   True
      Width           =   620
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Event
		Sub Shown()
		  Image = new WebFile
		  image.Filename = "logo.png"
		  image.Data = DecodeBase64(LogoBase64)
		  
		  
		  
		  ImageViewer1.URL = Image.URL
		  
		  
		  TextArea1.Text = TextLorem
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Destructor()
		  Image = nil
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Image As WebFile
	#tag EndProperty


	#tag Constant, Name = LogoBase64, Type = String, Dynamic = False, Default = \"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\x3D", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TextLorem, Type = String, Dynamic = False, Default = \"Lorem ipsum dolor sit amet\x2C consectetur adipiscing elit. Etiam pretium nulla diam\x2C vitae sollicitudin dui condimentum vitae. Donec nibh enim\x2C pulvinar ut pretium eget\x2C vestibulum et dui. Aliquam mattis ultrices lectus\x2C eget accumsan enim feugiat quis. Duis vestibulum lectus id nibh facilisis\x2C a vulputate eros placerat. Duis ac est quis diam viverra venenatis. Donec suscipit\x2C quam at feugiat viverra\x2C nibh turpis dictum velit\x2C sed gravida elit nulla a quam. Morbi hendrerit nibh non ex elementum porttitor. Vestibulum ultrices odio a sagittis commodo. Donec volutpat efficitur nisl\x2C in accumsan risus tempus et.\r\rAliquam ultricies sodales aliquet. Vivamus congue est ac bibendum euismod. Phasellus in tortor nisi. Nulla nec dapibus enim. Sed sed dui vel ante hendrerit cursus quis vel mi. Nunc semper\x2C sapien quis pharetra sollicitudin\x2C tellus dui molestie tellus\x2C eu tempus nibh dolor quis purus. Duis cursus nulla lorem\x2C sit amet maximus elit vehicula at. Integer facilisis dui aliquam enim pharetra viverra. Proin eros est\x2C sagittis id consectetur vel\x2C dignissim sed nibh. Integer mattis tempus libero sed convallis. Mauris dictum arcu arcu. Quisque semper commodo faucibus.\r\rSed ex purus\x2C tempor sit amet euismod nec\x2C porttitor ac leo. Orci varius natoque penatibus et magnis dis parturient montes\x2C nascetur ridiculus mus. Phasellus et ipsum arcu. Mauris id urna orci. Donec consectetur enim quis velit egestas placerat. Morbi tincidunt ipsum id orci iaculis semper. Integer et ullamcorper diam. Praesent mi magna\x2C sollicitudin a massa nec\x2C bibendum consequat risus. Sed vitae tempor augue. Aliquam erat volutpat. Pellentesque pellentesque\x2C purus vel lobortis eleifend\x2C turpis tellus hendrerit lectus\x2C eu feugiat tellus ante ac mi.\r\rDonec viverra sapien ligula\x2C venenatis molestie leo congue a. Sed auctor vel ipsum accumsan accumsan. Nulla auctor sem eu finibus placerat. Nulla facilisi. Sed ullamcorper pellentesque posuere. Nunc facilisis nisl vitae condimentum porta. Ut commodo enim at metus consequat malesuada.\r\rProin eu erat tincidunt\x2C cursus ante sed\x2C lobortis est. Class aptent taciti sociosqu ad litora torquent per conubia nostra\x2C per inceptos himenaeos. Pellentesque rhoncus eget sem vel congue. Donec accumsan sem ligula\x2C at mattis sem lacinia condimentum. Etiam non convallis erat\x2C eu egestas ipsum. Donec eu nulla tellus. Fusce fermentum neque magna\x2C eget posuere arcu semper sed. Sed est elit\x2C rutrum ultrices mollis quis\x2C imperdiet sit amet leo. Interdum et malesuada fames ac ante ipsum primis in faucibus.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Rectangle1
	#tag Event
		Sub Opening()
		  me.Style.BackgroundColor = &CEFEFEF
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
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="ScrollDirection"
		Visible=true
		Group="Behavior"
		InitialValue="ScrollDirections.None"
		Type="WebContainer.ScrollDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - None"
			"1 - Horizontal"
			"2 - Vertical"
			"3 - Both"
		#tag EndEnumValues
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
		Name="LayoutType"
		Visible=true
		Group="View"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutDirection"
		Visible=true
		Group="View"
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
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="OldWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Oldheight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="isDialog"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=false
		Group=""
		InitialValue="250"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=false
		Group=""
		InitialValue="250"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
