describe('Header', () => {
  beforeEach(() => {
    cy.visit('https://resume.northof66.com')
  })
  it('has a header', () => {
    cy.contains('Rhyss Vivian')
  })
})