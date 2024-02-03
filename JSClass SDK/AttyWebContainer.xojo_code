#tag Class
Protected Class AttyWebContainer
Inherits WebContainer
	#tag Event
		Sub Closed()
		  try
		    
		    //NB: Delegates were added because in the code you can add the event handler to the webcontainer via 
		    //AddHandler on the close event. If that event is set by code for the target screen it cannot be added to the JSPanel close events. 
		    //The result is that there is no other way to close the dialog if the container is closed
		    
		    if fnCloseDialog <> nil then
		      fnCloseDialog.Invoke
		      fnCloseDialog = nil
		    end if 
		    
		    RaiseEvent Close
		    
		  catch e as NilObjectException
		    
		  catch e as OutOfBoundsException
		    
		  catch ex as RuntimeException
		    
		  end try
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  OldWidth = self.Width
		  Oldheight = self.Height
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  RaiseEvent Resized
		End Sub
	#tag EndEvent


	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub CloseDialog()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Destructor()
		  fnUpdateDataDialog = nil
		  fnCloseDialog = nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FireResize()
		  
		  if self.OldWidth > 0 OR self.Oldheight > 0 then
		    
		    for each c as WebUIControl in Controls
		      
		      var nuovaLarghezza as integer
		      var nuovaAltezza as integer 
		      
		      
		      var spaziosotto as Integer = self.Oldheight-c.Top-c.Height
		      var spaziodx as Integer = self.OldWidth-c.Left-c.Width
		      
		      var nuovoMargineSinistro as Integer = self.Width-c.Width-spaziodx
		      var nuovoMarginealto as Integer = self.Height-c.Height-spaziosotto
		      
		      if c.LockLeft AND c.LockRight then
		        nuovaLarghezza= self.Width -c.Left -spaziodx
		      else
		        nuovaLarghezza= c.Width
		        
		      end if 
		      
		      
		      if c.LockTop AND c.LockBottom then
		        nuovaAltezza= self.Height -c.Top -spaziosotto
		      else
		        nuovaAltezza = c.Height
		      end if 
		      
		      if not c.LockLeft AND c.LockTop AND c.LockRight then //Varia solo in orizzontale
		        c.Left = nuovoMargineSinistro
		      elseif not c.LockLeft AND c.LockBottom AND c.LockRight then
		        c.Left = nuovoMargineSinistro
		        c.Top  = nuovoMarginealto
		        
		        
		      end if
		      
		      
		      if c.LockTop AND not c.LockBottom AND not c.LockLeft  AND not c.LockRight then
		        nuovaLarghezza = c.Width
		        nuovaAltezza = c.Height
		        c.Left = c.Parent.Width/2-c.Width/2
		      end if 
		      
		      c.Width = nuovaLarghezza
		      c.Height = nuovaAltezza
		      
		    Next
		    
		    RaiseEvent Resized
		    
		  end if 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InvokeUpdateDataDialog(d as Dictionary)
		  if fnUpdateDataDialog <> nil then
		    fnUpdateDataDialog.Invoke(d)
		  end if 
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub UpdateDataDialog(d as Dictionary)
	#tag EndDelegateDeclaration


	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CloseDialog()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resized()
	#tag EndHook


	#tag Property, Flags = &h0
		fnCloseDialog As CloseDialog
	#tag EndProperty

	#tag Property, Flags = &h0
		fnUpdateDataDialog As UpdateDataDialog
	#tag EndProperty

	#tag Property, Flags = &h0
		isDialog As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Oldheight As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		OldWidth As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ControlCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
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
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="300"
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="300"
			Type="Integer"
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
	#tag EndViewBehavior
End Class
#tag EndClass
