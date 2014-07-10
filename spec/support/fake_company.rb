class FakeCompany
  def initialize
    @company = Company.create!({
      :name => "GWPH"
    })
  end

  def fake_company
    @company
  end
end