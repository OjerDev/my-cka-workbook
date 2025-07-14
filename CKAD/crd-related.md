Define a Kubernetes custom resource definition (CRD) for a new resource kind called Foo (plural form - foos) in the samplecontroller.example.com group.

This CRD should have a version of v1alpha1 with a schema that includes two properties as given below:


deploymentName (a string type) and replicas (an integer type with minimum value of 1 and maximum value of 5).



It should also include a status subresource which enables retrieving and updating the status of Foo object, including the availableReplicas property, which is an integer type.
The Foo resource should be namespace scoped.


Note: We have provided a template /root/foo-crd-aecs.yaml for your ease. There are few issues with it so please make sure to incorporate the above requirements before deploying on cluster.

student-node ~ ➜  kubectl config use-context cluster3
Switched to context "cluster3".

student-node ~ ➜  vim foo-crd-aecs.yaml

student-node ~ ➜  cat foo-crd-aecs.yaml 
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: foos.samplecontroller.example.com
spec:
  group: samplecontroller.example.com
  scope: Namespaced
  names:
    kind: Foo
    plural: foos
  versions:
  - name: v1alpha1
    served: true
    storage: true
    schema:
      # schema used for validation
      openAPIV3Schema:
        type: object
        properties:
          spec:
            # Spec for schema goes here !
            type: object
            properties:
              deploymentName:
                type: string
              replicas:
                type: integer
                minimum: 1
                maximum: 5
          status:
            type: object
            properties:
              availableReplicas:
                type: integer
    # subresources for the custom resource
    subresources:
      # enables the status subresource
      status: {}

student-node ~ ➜  kubectl apply -f foo-crd-aecs.yaml
customresourcedefinition.apiextensions.k8s.io/foos.samplecontroller.example.com created

========

