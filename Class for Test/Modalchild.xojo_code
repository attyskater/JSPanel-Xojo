#tag WebContainerControl
Begin AttyWebContainer Modalchild
   Compatibility   =   ""
   ControlID       =   ""
   Enabled         =   True
   Height          =   160
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
   Width           =   199
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mName          =   ""
   _mPanelIndex    =   -1
   Begin WebButton Button1
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Close"
      ControlID       =   ""
      Default         =   True
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   1
      Left            =   47
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      TabIndex        =   5
      Tooltip         =   ""
      Top             =   88
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebDatePicker DatePicker1
      AllowKeyboardEntry=   True
      ControlID       =   ""
      EarliestDate    =   ""
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   ""
      LatestDate      =   ""
      Left            =   29
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   2
      TabIndex        =   6
      Tooltip         =   ""
      Top             =   34
      Visible         =   True
      Width           =   150
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Constant, Name = TextLorem, Type = String, Dynamic = False, Default = \"Lorem ipsum dolor sit amet\x2C consectetur adipiscing elit. Etiam pretium nulla diam\x2C vitae sollicitudin dui condimentum vitae. Donec nibh enim\x2C pulvinar ut pretium eget\x2C vestibulum et dui. Aliquam mattis ultrices lectus\x2C eget accumsan enim feugiat quis. Duis vestibulum lectus id nibh facilisis\x2C a vulputate eros placerat. Duis ac est quis diam viverra venenatis. Donec suscipit\x2C quam at feugiat viverra\x2C nibh turpis dictum velit\x2C sed gravida elit nulla a quam. Morbi hendrerit nibh non ex elementum porttitor. Vestibulum ultrices odio a sagittis commodo. Donec volutpat efficitur nisl\x2C in accumsan risus tempus et.\r\rAliquam ultricies sodales aliquet. Vivamus congue est ac bibendum euismod. Phasellus in tortor nisi. Nulla nec dapibus enim. Sed sed dui vel ante hendrerit cursus quis vel mi. Nunc semper\x2C sapien quis pharetra sollicitudin\x2C tellus dui molestie tellus\x2C eu tempus nibh dolor quis purus. Duis cursus nulla lorem\x2C sit amet maximus elit vehicula at. Integer facilisis dui aliquam enim pharetra viverra. Proin eros est\x2C sagittis id consectetur vel\x2C dignissim sed nibh. Integer mattis tempus libero sed convallis. Mauris dictum arcu arcu. Quisque semper commodo faucibus.\r\rSed ex purus\x2C tempor sit amet euismod nec\x2C porttitor ac leo. Orci varius natoque penatibus et magnis dis parturient montes\x2C nascetur ridiculus mus. Phasellus et ipsum arcu. Mauris id urna orci. Donec consectetur enim quis velit egestas placerat. Morbi tincidunt ipsum id orci iaculis semper. Integer et ullamcorper diam. Praesent mi magna\x2C sollicitudin a massa nec\x2C bibendum consequat risus. Sed vitae tempor augue. Aliquam erat volutpat. Pellentesque pellentesque\x2C purus vel lobortis eleifend\x2C turpis tellus hendrerit lectus\x2C eu feugiat tellus ante ac mi.\r\rDonec viverra sapien ligula\x2C venenatis molestie leo congue a. Sed auctor vel ipsum accumsan accumsan. Nulla auctor sem eu finibus placerat. Nulla facilisi. Sed ullamcorper pellentesque posuere. Nunc facilisis nisl vitae condimentum porta. Ut commodo enim at metus consequat malesuada.\r\rProin eu erat tincidunt\x2C cursus ante sed\x2C lobortis est. Class aptent taciti sociosqu ad litora torquent per conubia nostra\x2C per inceptos himenaeos. Pellentesque rhoncus eget sem vel congue. Donec accumsan sem ligula\x2C at mattis sem lacinia condimentum. Etiam non convallis erat\x2C eu egestas ipsum. Donec eu nulla tellus. Fusce fermentum neque magna\x2C eget posuere arcu semper sed. Sed est elit\x2C rutrum ultrices mollis quis\x2C imperdiet sit amet leo. Interdum et malesuada fames ac ante ipsum primis in faucibus.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Button1
	#tag Event
		Sub Pressed()
		  self.Close
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
