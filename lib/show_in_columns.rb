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
    concat("<tr>", proc.binding)
    i = 0
    collection.each do |obj|
      concat("</tr><tr>", proc.binding) if (i%columns) == 0 && i != 0
      proc.call(collection[i])
      i+=1
    end
    concat("</tr>", proc.binding)
  end
end
