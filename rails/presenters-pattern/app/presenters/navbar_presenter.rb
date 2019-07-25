# frozen_string_literal: true

# This presenter is not decorating any model or class.
# It can be understood as a collection of related and encapsulated methods to be used
# in the views with the ability to create HTML from ruby code.
class NavbarPresenter < Keynote::Presenter

  def section_for(step, steps: Array(step), url: step)
    build_html do
      li class: pill_class(steps) do
        link_to(url) do
          build_html do
            span class: 'nav-steps__step-number'
            span t(".#{step}"), class: 'nav-steps__step-title'
            span class: 'icon-check'
          end
        end
      end
    end
  end

  def active?(section)
    # ...
  end

  private

  def pill_class(sections)
    # ...
  end

end
