class ContributorAgreement
  attr_reader :curation_concern, :user
  def initialize(curation_concern, user, params)
    @curation_concern = curation_concern
    @user = user
    @param_value = params[param_key.to_sym] || params[param_key.to_s]
  end

  def legally_binding_text
    <<-HTML
    <p>
      I am submitting my work for inclusion in the #{I18n.t('sufia.product_name')} repository maintained by the University Libraries of the University of Notre Dame.
      I acknowledge that publication of the work may implicate my legal rights with respect to the work and its contents, including my ability to publish the work in other venues.
      I UNDERSTAND AND AGREE THAT BY SUBMITTING MY CONTENT FOR INCLUSION IN THE #{I18n.t('sufia.product_name')} REPOSITORY, I AGREE TO THE FOLLOWING TERMS:
    </p>

    <p>
      I hereby grant the University of Notre Dame permission to reproduce, edit, publish, disseminate, publicly display, or publicly perform, in whole or in part, the work in any medium at the University&rsquo;s discretion (including but not limited to public websites).
      I agree that the University can keep more than one copy of the submission for the purpose of preservation and security.
      I agree that the University can preserve the submission by migrating or translating it to a new format or medium as needed in the future.
      I also agree that the metadata attached to the item can be reviewed and altered by the University to aid in preservation and discovery.
      I understand that I may be allowed the opportunity to select the intended audience for the materials that I submit, and I agree that I am fully responsible for any claims and all responsibility for materials submitted.
      The #{I18n.t('sufia.product_name')} service is offered as-is with no warranties, express or implied.
      The University may suspend or terminate #{I18n.t('sufia.product_name')}, or remove any content within the system, at any time for any reason in the University&rsquo;s sole discretion.
    </p>

    <p>
      I warrant that the submitted material is original to me and that I have power to make this agreement.
      I also warrant that the submission does not, to the best of my knowledge, infringe upon anyone&rsquo;s copyright.
      I also warrant that if the work has been previously published elsewhere in whole or in part, that I have obtained the permission of the copyright owner to grant #{I18n.t('sufia.product_name')} the rights required by this license.
      I also guarantee that I do not have any other publication agreements that involve this material or substantial parts of it that conflict with my submission of materials for dissemination in #{I18n.t('sufia.product_name')}.
    </p>

    <p>
      I represent that any materials that are used in this submission that I do not hold copyright for, I have obtained permission to use and display the materials according to the rights required by this license, and that third-party owned materials are clearly identified and credited within the content of the submission.
      If it is determined that permissions of use have not properly been obtained, I acknowledge that the University may remove or restrict access to items as necessary.
    </p>

    <p>
      I understand that I may request the University to remove my submitted materials from the #{I18n.t('sufia.product_name')} repository; however, I acknowledge that the University cannot control or retract works that may have been accessed by third parties prior to my request for removal.
      If the submission is removed I agree that the item can be replaced by a page with a statement declaring that the item was removed by my request.
    </p>
    HTML
  end

  def acceptance_value
    'accept'
  end

  def param_key
    :accept_contributor_agreement
  end
  attr_reader :param_value

  def is_being_accepted?
    param_value == acceptance_value
  end
end
