module ShowInColumns
  # show content in <tr>
  #
  # <table>
	#   <% show_in_columns @users, 2 do |user| -%>
	# 	  <td valign="top"><%=user.name%></td>
	#   <% end -%>
	# </table>
  # will generate
  # <tr>
  #   <td>Name 1</td>
  #   <td>Name 2</td>
  # </tr>
  # <tr>
  #   <td>Name 3</td>
  # </tr>
  def show_in_columns(collection, columns = 2, &proc)
    concat("<tr>")
    
    i = 0
    
    case collection
    when Hash
      collection.each do |k, v|
        concat("</tr><tr>") if (i%columns) == 0 && i != 0
        proc.call(k, v)
        i+=1
      end
    else
      collection.each do |v|
        concat("</tr><tr>") if (i%columns) == 0 && i != 0
        proc.call(v)
        i+=1
      end
    end
    
    concat("</tr>")
  end
end