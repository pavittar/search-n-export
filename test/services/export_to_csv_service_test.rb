require 'test_helper'

class ExportToCSVServiceTest < ActiveSupport::TestCase
  test 'should export all' do
    csv = ExportToCSVService.call(Author.all)
    assert_equal "ID,Author Name,Songs Count,Created At\n298486374,Rosendo Carter,0,28 Feb 00:00\n980190962,Marceline Mayert,0,29 Feb 00:00\n", csv
  end

  test 'should export scoped' do
    csv = ExportToCSVService.call(Author.ransack({ first_name_or_last_name_cont: 'Marceline' }).result)
    assert_equal "ID,Author Name,Songs Count,Created At\n980190962,Marceline Mayert,0,29 Feb 00:00\n", csv
  end

  test 'should export with selected fields' do
    csv = ExportToCSVService.call(
      Author.ransack({ first_name_or_last_name_cont: 'Marceline' }).result,
      ['ID', 'Author Name']
    )
    assert_equal "ID,Author Name\n980190962,Marceline Mayert\n", csv
  end

  test 'should export with selected - invalid fields' do
    csv = ExportToCSVService.call(
      Author.ransack({ first_name_or_last_name_cont: 'Marceline' }).result,
      ['Author Name', 'Updated At']
    )
    assert_equal "Author Name\nMarceline Mayert\n", csv
  end

  test 'should export scoped songs' do
    csv = ExportToCSVService.call(Song.ransack({ title_cont: 'Tempora' }).result)
    assert_equal "ID,Title,Author Name,Year\n980190962,Tempora in at nostrum.,Marceline Mayert,1\n", csv
  end

  test 'should raise NotImplementedError' do
    assert_raise(NotImplementedError) { ExportToCSVService.call(Download.all) }
  end
end