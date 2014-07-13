class FakeCompany
  def initialize
    puts "fake company"
    @company = Company.create!({
      :name => "GWPH"
    })
  end

  def fake_company
    @company
  end
end