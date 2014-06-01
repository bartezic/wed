# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Routes', type: :routing do

  context 'root' do
    it 'categories' do
      expect(get:    '/posluhy/7'     ).to route_to(controller: 'categories', action: 'show', id: '7')
      expect(get:    '/posluhy'       ).not_to be_routable
      # expect(get:    '/posluhy/new'   ).not_to be_routable
      expect(get:    '/posluhy/7/edit').not_to be_routable
      expect(put:    '/posluhy/7'     ).not_to be_routable
      expect(post:   '/posluhy'       ).not_to be_routable
      expect(delete: '/posluhy/7'     ).not_to be_routable
    end
  end

  context 'client' do

  end

  context 'admin' do

  end

end
