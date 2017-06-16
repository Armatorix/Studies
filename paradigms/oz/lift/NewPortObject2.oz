declare
proc {NewPortObject2 Proc ?P}
   Sin in
   thread for Msg in Sin do {Proc Msg} end end
   {NewPort Sin P}
end
