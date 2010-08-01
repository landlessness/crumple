module DropBoxesHelper
  def person_drop_box_vcf_path(person, drop_box)
    person_drop_box_path(person, drop_box) + '/crumple.vcf'
  end
end
