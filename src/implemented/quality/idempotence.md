# Idempotence

In computer science, idempotence is an attribute of a computer system that allows operations and subroutines to be repeated, re-run and retried without causing unintended side effects.

Idempotent systems that people encounter in their day-to-day lives include lifts and pedestrian crossings. The initial press of a button moves these systems into a new state (requesting the lift or requesting a safe crossing of the road). Subsequent pushes of the button – between the initial activation and the request being satisfied – have no effect.

Idempotent operations are useful in client-server systems. Client components may not always be able to guarantee that its server requests have been processed by the server (for example, in the event of a network failure). So, it is beneficial for client components to be able to resend requests to the server, without running the risk that duplicate requests will have unintended consequences for the server's state.
