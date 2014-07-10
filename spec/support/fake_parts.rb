class FakeParts
  def initialize(f_report)
    @parts = []
    @parts << f_report.fake_report.parts.create!({
      :description => "Sand benches",
      :barcode => "OIUBL87"
    })
    @parts << f_report.fake_project.parts.create!({
      :description => "Nail bleachers",
      :barcode => "XYZAWY9"
    })
  end

  def fake_parts
    @parts
  end
end
