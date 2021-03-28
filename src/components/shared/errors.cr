class Shared::OpErrors(T) < BaseComponent
  needs op : Avram::SaveOperation(T)

  def render
    if op
      ul do
        op.errors.each do |field, field_errors|
         field_errors.each do |error_msg|
          li "#{field} #{error_msg}"
         end
        end
      end
    end
  end
end
