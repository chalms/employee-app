class FakeReportsParts
  def initialize(parts, users_reports)
    @parts = parts
    while(@parts.length > 0)
      users_reports.each do |u_r|
        break if (@parts.length == 0)
        part = @parts.pop

        unless (part.assignment)
          u_r.reports_parts.create!({
            :part_id => part.id
          })
        end
      end
    end
  end
end