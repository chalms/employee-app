class Metrics.Views.Reports extends Marionette.CollectionView
  itemView: Metrics.Views.ReportLineItem
  template: JST['templates/reports/reports']
  tagName: 'ul'
