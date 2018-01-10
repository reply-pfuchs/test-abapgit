*&---------------------------------------------------------------------*
*& Report  ZFUCHS_TEST
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ZFUCHS_TEST.
cl_http_client=>create(
  EXPORTING
    host               = 'www.google.com'
    proxy_host         = '10.65.1.15'
    proxy_service      = '8080'
  IMPORTING
    client             = data(client)    " HTTP Client Abstraction
  EXCEPTIONS
    argument_not_found = 1
    plugin_not_active  = 2
    internal_error     = 3
    others             = 4
).

CHECK sy-subrc = 0.

client->send(
  EXCEPTIONS
    http_communication_failure = 1
    http_invalid_state         = 2
    http_processing_failed     = 3
    http_invalid_timeout       = 4
    others                     = 5
).

CHECK sy-subrc = 0.

client->receive(
  EXCEPTIONS
    http_communication_failure = 1
    http_invalid_state         = 2
    http_processing_failed     = 3
    others                     = 4
).

cl_demo_output=>display( client->response->get_cdata( ) ).
