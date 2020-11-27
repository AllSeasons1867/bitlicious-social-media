# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can :read, :all
      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    can(:manage, Comment) do |comment|
      user == comment.user
    end
    can(:manage, Picture) do |picture|
      user == picture.user
    end
    can(:manage, Post) do |post|
      user == post.user
    end
    can(:manage, Story) do |story|
      user == story.user
    end
    can(:manage, VideoComment) do |video_comment|
      user == video_comment.user
    end
    can(:manage, Video) do |video|
      user == video.user
    end
    can(:manage, PictureComment) do |picture_comment|
      user == picture_comment.user
    end
    can(:manage, StoryComment) do |story_comment|
      user == story_comment.user
    end
  end
end
