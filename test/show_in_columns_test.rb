require File.join(File.dirname(__FILE__),'test_helper')

class ShowInColumnsTest < ActiveSupport::TestCase
  context "The ShowInColumns" do
    setup do
      @view = ActionView::Base.new
    end
    
    should "be a helper" do
      assert_respond_to(@view, :show_in_columns)
    end
    
    context "using ERB" do
      context "with an Array" do
        setup do
          @data = %w(Mozart Beethoven Bach Tchaikovsky Vivaldi)
        end
        
        context "with 2 columns" do
          setup do
            @content = <<-CODE
              <table>
            		<% show_in_columns data do |d| -%>
            			<td><%= d %></td>
            		<% end -%>
            	</table>
            CODE
          end
          
          should "render the table" do
            rendered = @view.render(:inline=>@content, :locals => { :data => @data })
          
            table = <<-TABLE
              <table>
                <tr>
            			<td>Mozart</td>
            			<td>Beethoven</td>
            		</tr>
                <tr>
                  <td>Bach</td>
                  <td>Tchaikovsky</td>
                </tr>
                <tr>
                  <td>Vivaldi</td>
                </tr>
            	</table>
            TABLE
          
            assert_equal_html(table, rendered)
          end
        end
        
        context "with 3 columns" do
          setup do
            @content = <<-CODE
              <table>
            		<% show_in_columns data, 3 do |d| -%>
            			<td><%= d %></td>
            		<% end -%>
            	</table>
            CODE
          end
          
          should "render the table" do
            rendered = @view.render(:inline=>@content, :locals => { :data => @data })
          
            table = <<-TABLE
              <table>
                <tr>
            			<td>Mozart</td>
            			<td>Beethoven</td>
                  <td>Bach</td>
                </tr>
                <tr>
                  <td>Tchaikovsky</td>
                  <td>Vivaldi</td>
                </tr>
            	</table>
            TABLE
          
            assert_equal_html(table, rendered)
          end
        end
      end
      
      context "with a Hash" do
        setup do
          @data = { 1 => 'Mozart', 2 => 'Beethoven', 3 => 'Bach', 4 => 'Tchaikovsky', 5 => 'Vivaldi' }.sort_by { |k, v| k }
        end
        
        context "with 2 columns" do
          setup do
            @content = <<-CODE
              <table>
            		<% show_in_columns data do |k, v| -%>
            			<td><%= k %> - <%= v %></td>
            		<% end -%>
            	</table>
            CODE
          end
          
          should "render the table" do
            rendered = @view.render(:inline=>@content, :locals => { :data => @data })
          
            table = <<-TABLE
              <table>
                <tr>
            			<td>1 - Mozart</td>
            			<td>2 - Beethoven</td>
            		</tr>
                <tr>
                  <td>3 - Bach</td>
                  <td>4 - Tchaikovsky</td>
                </tr>
                <tr>
                  <td>5 - Vivaldi</td>
                </tr>
            	</table>
            TABLE
          
            assert_equal_html(table, rendered)
          end
        end
        
        context "with 3 columns" do
          setup do
            @content = <<-CODE
              <table>
            		<% show_in_columns data, 3 do |k, v| -%>
            			<td><%= k %> - <%= v %></td>
            		<% end -%>
            	</table>
            CODE
          end
          
          should "render the table" do
            rendered = @view.render(:inline=>@content, :locals => { :data => @data })
          
            table = <<-TABLE
              <table>
                <tr>
            			<td>1 - Mozart</td>
            			<td>2 - Beethoven</td>
                  <td>3 - Bach</td>
                </tr>
                <tr>
                  <td>4 - Tchaikovsky</td>
                  <td>5 - Vivaldi</td>
                </tr>
            	</table>
            TABLE
          
            assert_equal_html(table, rendered)
          end
        end
      end
      
      context "with an Array of Structs" do
        setup do
          @data = []
          names = %w(Mozart Beethoven Bach Tchaikovsky Vivaldi)
          
          5.times do |i| 
            @data << Someone.new(names[i])
          end
        end
        
        context "with 2 columns" do
          setup do
            @content = <<-CODE
              <table>
            		<% show_in_columns data do |user| -%>
            			<td><%= user.name %></td>
            		<% end -%>
            	</table>
            CODE
          end
          
          should "render the table" do
            rendered = @view.render(:inline=>@content, :locals => { :data => @data })
          
            table = <<-TABLE
              <table>
                <tr>
            			<td>Mozart</td>
            			<td>Beethoven</td>
            		</tr>
                <tr>
                  <td>Bach</td>
                  <td>Tchaikovsky</td>
                </tr>
                <tr>
                  <td>Vivaldi</td>
                </tr>
            	</table>
            TABLE
          
            assert_equal_html(table, rendered)
          end
        end
        
        context "with 3 columns" do
          setup do
            @content = <<-CODE
              <table>
            		<% show_in_columns data, 3 do |v| -%>
            			<td><%= v.name %></td>
            		<% end -%>
            	</table>
            CODE
          end
          
          should "render the table" do
            rendered = @view.render(:inline=>@content, :locals => { :data => @data })
          
            table = <<-TABLE
              <table>
                <tr>
            			<td>Mozart</td>
            			<td>Beethoven</td>
                  <td>Bach</td>
                </tr>
                <tr>
                  <td>Tchaikovsky</td>
                  <td>Vivaldi</td>
                </tr>
            	</table>
            TABLE
          
            assert_equal_html(table, rendered)
          end
        end
      end
    end
  end
end