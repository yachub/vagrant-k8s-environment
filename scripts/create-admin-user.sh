if [ ! -f ~/.kube/config  ]; then
    ln -s /etc/kubernetes/admin.conf ~/.kube/config
fi

if [[ ! $(kubectl -n kube-system get secret | grep admin-user) ]]; then
	cat <<-EOF | kubectl create -f -
	apiVersion: v1
	kind: ServiceAccount
	metadata:
	  name: admin-user
	  namespace: kube-system
	EOF

	cat <<-EOF | kubectl create -f -
	apiVersion: rbac.authorization.k8s.io/v1
	kind: ClusterRoleBinding
	metadata:
	  name: admin-user
	roleRef:
	  apiGroup: rbac.authorization.k8s.io
	  kind: ClusterRole
	  name: cluster-admin
	subjects:
	- kind: ServiceAccount
	  name: admin-user
	  namespace: kube-system
	EOF

	kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}') > /vagrant/files/service-account-token
fi
