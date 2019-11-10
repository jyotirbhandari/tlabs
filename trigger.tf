resource "null_resource" "fizzbuzz" {
  depends_on = [module.eks_cluster]

  provisioner "local-exec" {
    working_dir = path.module

    command = <<EOS
sleep 20;
kubectl apply --kubeconfig "kubeconfig_${var.eks_cluster_name}" -f app.yaml;
sleep 50;
kubectl --kubeconfig "kubeconfig_${var.eks_cluster_name}" logs fizzbuzz-challenge | tail -n 3;
kubectl --kubeconfig "kubeconfig_${var.eks_cluster_name}" get pods;
echo "Hopefully challenge is successfull";
EOS
  }
}

