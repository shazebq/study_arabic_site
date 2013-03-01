require 'spec_helper'

describe TeacherProfile do
  before :each do
    @teacher_profile = FactoryGirl.build(:teacher_profile)
  end

  subject { @teacher_profile }

  it { should(respond_to :user) }
  
  it "should create a user AND teacher profile" do
    @teacher_profile_with_user = { field_of_study: "bachelors in Arabic", university: "Cairo University",
                                  years_of_experience: 2, specialties: "Classical Arabic", online: true, in_person: false,
                                  user_attributes: { first_name: "John", last_name: "Khan", email: "jkhan@example.com",
                                                     password: "cool123", password_confirmation: "cool123" } }
    profile = TeacherProfile.create!(@teacher_profile_with_user)
    profile.id.should_not be_nil
    profile.user.should_not be_nil
  end

  describe "scopes" do
    let!(:teacher_profile1) { FactoryGirl.create(:teacher_profile, reviews_count: 1, online: true, in_person: true, price_per_hour: 5) }
    let!(:user1) { FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: teacher_profile1.id) }
    let!(:review1a) { FactoryGirl.create(:review, rating: 5, reviewable_type: "TeacherProfile", reviewable_id: teacher_profile1.id) }
    let!(:review1b) { FactoryGirl.create(:review, rating: 5, reviewable_type: "TeacherProfile", reviewable_id: teacher_profile1.id) }
    
    let!(:teacher_profile2) { FactoryGirl.create(:teacher_profile, reviews_count: 2, online: true, in_person: false, price_per_hour: 3 ) }
    let!(:user2) { FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: teacher_profile2.id) }
    let!(:review2a) { FactoryGirl.create(:review, rating: 2, reviewable_type: "TeacherProfile", reviewable_id: teacher_profile2.id) }
    let!(:review2b) { FactoryGirl.create(:review, rating: 1, reviewable_type: "TeacherProfile", reviewable_id: teacher_profile2.id) }

    let!(:teacher_profile3) { FactoryGirl.create(:teacher_profile, reviews_count: 3, online: false, in_person: true, price_per_hour: 9) }
    let!(:user3) { FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: teacher_profile3.id) }
    let!(:review3a) { FactoryGirl.create(:review, rating: 3, reviewable_type: "TeacherProfile", reviewable_id: teacher_profile3.id) }
    let!(:review3b) { FactoryGirl.create(:review, rating: 4, reviewable_type: "TeacherProfile", reviewable_id: teacher_profile3.id) }
    
    let!(:teacher_profile4) { FactoryGirl.create(:teacher_profile, reviews_count: 0, online: false, in_person: true, price_per_hour: 15) }
    let!(:user4) { FactoryGirl.create(:user, profile_type: "TeacherProfile", profile_id: teacher_profile4.id) }

    describe "most reviews descending" do
      it "should sort teachers by number of reviews descending" do
        TeacherProfile.order_by_reviews.first.should == teacher_profile3
        TeacherProfile.order_by_reviews.last.should == teacher_profile4
      end
    end

    describe "highest rated" do
      it "should sort teachers by average rating" do
        TeacherProfile.order_by_average_rating.first.should == teacher_profile1
        TeacherProfile.order_by_average_rating.last.should == teacher_profile2
      end
    end

    describe "instruction type filters" do
      describe "online only filter" do
        it "should return teachers that only teach online" do
          TeacherProfile.online_filter.should have(2).items 
          TeacherProfile.online_filter.should include(teacher_profile1, teacher_profile2)
        end
      end

      describe "in person only filter" do
        it "should return teachers that only teach in person" do
          TeacherProfile.in_person_filter.should have(3).items 
          TeacherProfile.in_person_filter.should include(teacher_profile1, teacher_profile3)
        end
      end  

      describe "online filter ordered by average rating" do
        it "should return teachers that teach online only ordered by average rating" do
          (TeacherProfile.order_by_average_rating.online_filter + TeacherProfile.zero_review_records.online_filter).
            should == [teacher_profile1, teacher_profile2]
        end
      end

      describe "in person filter ordered by average rating" do
        it "should return teachers that teach only in person ordered by average rating" do
          (TeacherProfile.order_by_average_rating.in_person_filter + TeacherProfile.zero_review_records.in_person_filter).
            should == [teacher_profile1, teacher_profile3, teacher_profile4] 
        end
      end
    end

    describe "price filters" do
      describe "filter of 5 dollars or less" do
        it "should return all the teacher profiles whose price per hour is 5 or less" do
          TeacherProfile.price_option(5).should include(teacher_profile1, teacher_profile2)
          TeacherProfile.price_option(5).length.should == 2
        end
      end

      describe "filter of 12 dollars or less" do
        it "should return all the teacher profiles who price per hour is 12 or less" do
          TeacherProfile.price_option(12).should include(teacher_profile1, teacher_profile2, teacher_profile3)
          TeacherProfile.price_option(12).length.should == 3
        end
      end
    end

    describe "chaining scopes from an array" do
      it "should apply all the scopes in the argument array" do
        #TeacherProfile.send_chain(["online_filter", "in_person_filter"]).should include(teacher_profile1, teacher_profile2, teacher_profile3, teacher_profile4)
        #TeacherProfile.send_chain(["online_filter", "in_person_filter"]).count.should == 4
      end
    end
  end
end

#comment


