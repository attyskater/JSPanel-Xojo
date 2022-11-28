#tag Class
Class AttyWebYesOrNOMSG
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(_id as String, _msg as String, _fnDelegationResponse as AttyWebJSPanel.DelegationResponse)
		  id = _id
		  MSG = _msg
		  fnDelegationResponse = _fnDelegationResponse
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  fnDelegationResponse = nil
		  
		  if Buttons<>Nil then
		    Buttons.RemoveAll
		    Buttons = nil
		  end if 
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Buttons() As AttyWebAlertButton
	#tag EndProperty

	#tag Property, Flags = &h0
		fnDelegationResponse As AttyWebJSPanel.DelegationResponse
	#tag EndProperty

	#tag Property, Flags = &h0
		ID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		MSG As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="ID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MSG"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
