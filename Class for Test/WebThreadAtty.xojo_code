#tag Class
Protected Class WebThreadAtty
Inherits WebThread
	#tag Event
		Sub Run()
		  Var context As New WebSessionContext(mSessionID)
		  // context will be Nil if the session no longer exists
		  If context <> Nil Then
		    
		    // You don't actually use the "context" variable, but
		    // now Session is available in this method.
		    
		    Thread_show("Loop 1...")
		    
		    for i as Integer = 0 to 10000000
		      
		    next
		    
		    Thread_MSG("Loop 2 ...")
		    
		    for i as Integer = 0 to 10000000
		      
		    next
		    
		    
		    
		    Thread_end
		    
		  End If
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1000
		Sub Constructor()
		  // Save the Session Identifier so we can look up the session later
		  // Session works here because the Constructor is called from within
		  // the current Session.
		  mSessionID = Session.Identifier
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  if self.ThreadProgress<>nil then
		    RemoveHandler self.ThreadProgress.CancelProgress, WeakAddressOf InterruptThread
		    self.ThreadProgress.Close
		    self.ThreadProgress = nil
		  end if 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InterruptThread(t as AttyWebJSPanel)
		  #pragma unused t
		  
		  self.Stop
		  
		  Thread_end
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Thread_end()
		  try
		    
		    if ThreadProgress <> nil then
		      RemoveHandler ThreadProgress.CancelProgress, WeakAddressOf InterruptThread
		      ThreadProgress.Close
		      ThreadProgress = nil
		    end if
		    
		    
		  Catch ex as runtimeexception
		    break
		  end
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Thread_MSG(_MSG as String)
		  if ThreadProgress <> nil then
		    
		    ThreadProgress.ChangeProgressMSG(_MSG)
		    
		    
		  end if 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Thread_show(Optional _msg as String)
		  
		  //NB: THIS METHOD IN THREADS MUST BE CALLED AFTER RETRIEVING THE SESSION CONTEX
		  if ThreadProgress = nil then
		    
		    ThreadProgress =  new AttyWebJSPanel
		    ThreadProgress.CancelProgress = True
		    ThreadProgress.isProgress = True //Set default MSG
		    if _msg<>"" then
		      ThreadProgress.ChangeProgressMSG _msg
		    end if
		    AddHandler ThreadProgress.CancelProgress, WeakAddressOf InterruptThread
		    Session.CurrentPage.AddControl(ThreadProgress)
		    
		    
		  end if 
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mSessionID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ThreadProgress As AttyWebJSPanel
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
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
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
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
	#tag EndViewBehavior
End Class
#tag EndClass
