class FakeReportsParts
  def initialize(parts, users_reports)
    @parts = parts
    while(@parts.length > 0)
      users_reports.each do |u_r|
        part = @parts.pop
        unless (part.assignment)
          u_r.reports_parts.create!({
            :part_id => part
          })
        end
      end
    end
  end
end